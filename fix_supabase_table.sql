-- ============================================================================
-- SUPABASE TABLE SETUP - AI Perfume Recommender
-- ============================================================================
-- Copy and paste this SQL into your Supabase SQL Editor to fix table structure

-- Step 1: Verify current table structure
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns 
WHERE table_name = 'analyses' 
ORDER BY ordinal_position;

-- Step 2: Create/recreate the analyses table with correct structure
-- WARNING: Uncomment the DROP TABLE line below ONLY if you want to start fresh
-- This will delete ALL existing data!
-- DROP TABLE IF EXISTS analyses CASCADE;

CREATE TABLE IF NOT EXISTS analyses (
    id BIGSERIAL PRIMARY KEY,
    user_image_url TEXT DEFAULT '',
    personality JSONB NOT NULL,
    perfumes JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Step 3: Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_analyses_created_at ON analyses(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_analyses_personality ON analyses USING GIN(personality);
CREATE INDEX IF NOT EXISTS idx_analyses_perfumes ON analyses USING GIN(perfumes);

-- Step 4: Enable Row Level Security
ALTER TABLE analyses ENABLE ROW LEVEL SECURITY;

-- Step 5: Create policy for access (allows all operations)
DROP POLICY IF EXISTS "Allow all operations on analyses" ON analyses;
CREATE POLICY "Allow all operations on analyses" ON analyses
    FOR ALL USING (true) WITH CHECK (true);

-- Step 6: Insert sample data with correct format (like your app produces)
INSERT INTO analyses (user_image_url, personality, perfumes, created_at) 
VALUES (
    '', -- Empty for quick recommendations, or base64 data URL for image uploads
    '{
        "description": "You exhibit sophisticated and refined characteristics with a preference for luxury and elegance",
        "traits": ["sophisticated", "confident", "elegant", "discerning", "charismatic"],
        "perfume_type": "Woody Oriental"
    }'::jsonb,
    '[
        {
            "brand": "Tom Ford",
            "name": "Oud Wood",
            "description": "A sophisticated blend of exotic rosewood, cardamom and sandalwood that captures the essence of rare oud wood",
            "image_url": "https://www.fragrantica.com/nez/crops/fragrance_b-10013139.jpg",
            "product_url": "https://www.amazon.com/s?k=tom+ford+oud+wood+perfume&ref=nb_sb_noss"
        },
        {
            "brand": "Creed",
            "name": "Aventus",
            "description": "A masculine scent perfect for the sophisticated gentleman who commands attention",
            "image_url": "https://www.fragrantica.com/nez/crops/fragrance_b-141487.jpg", 
            "product_url": "https://www.amazon.com/s?k=creed+aventus+perfume&ref=nb_sb_noss"
        },
        {
            "brand": "Maison Margiela",
            "name": "By the Fireplace",
            "description": "A cozy woody scent that evokes warmth and sophistication",
            "image_url": "https://www.fragrantica.com/nez/crops/fragrance_b-395154.jpg",
            "product_url": "https://www.amazon.com/s?k=maison+margiela+by+the+fireplace&ref=nb_sb_noss"
        }
    ]'::jsonb,
    NOW()
) ON CONFLICT DO NOTHING;

-- Step 7: Verify the data was inserted correctly
SELECT 
    id,
    CASE 
        WHEN user_image_url = '' THEN 'No Image'
        WHEN user_image_url LIKE 'data:image/%' THEN 'Base64 Image (' || length(user_image_url) || ' chars)'
        ELSE 'URL: ' || left(user_image_url, 50) || '...'
    END as image_info,
    personality->>'description' as personality_description,
    personality->'traits' as traits,
    personality->>'perfume_type' as perfume_type,
    jsonb_array_length(perfumes) as perfume_count,
    created_at
FROM analyses 
ORDER BY created_at DESC 
LIMIT 10;

-- Step 8: Check that JSON structure matches what the app expects
SELECT 
    id,
    personality ? 'description' as has_description,
    personality ? 'traits' as has_traits,
    personality ? 'perfume_type' as has_perfume_type,
    jsonb_typeof(personality->'traits') as traits_type,
    jsonb_typeof(perfumes) as perfumes_type
FROM analyses 
LIMIT 5;

-- Step 9: Verify perfume data structure
SELECT 
    id,
    perfume->>'brand' as brand,
    perfume->>'name' as name,
    perfume ? 'description' as has_description,
    perfume ? 'image_url' as has_image_url,
    perfume ? 'product_url' as has_product_url
FROM analyses,
     jsonb_array_elements(perfumes) as perfume
LIMIT 10;

-- Step 10: Show recent analyses (like the app displays)
SELECT 
    id,
    CASE 
        WHEN user_image_url = '' THEN '📝 Quick Recommendation'
        ELSE '🖼️ Image Analysis'
    END as analysis_type,
    personality->>'perfume_type' as perfume_type,
    jsonb_array_length(perfumes) as recommendations,
    to_char(created_at, 'YYYY-MM-DD HH24:MI:SS') as created_time,
    CASE 
        WHEN created_at > NOW() - INTERVAL '1 hour' THEN 'Just now'
        WHEN created_at > NOW() - INTERVAL '1 day' THEN extract(epoch from (NOW() - created_at))/3600 || 'h ago'
        ELSE extract(epoch from (NOW() - created_at))/86400 || 'd ago'
    END as time_ago
FROM analyses 
ORDER BY created_at DESC 
LIMIT 20;

-- ============================================================================
-- TROUBLESHOOTING QUERIES
-- ============================================================================

-- Check for any malformed JSON data
SELECT id, 'personality' as field, personality 
FROM analyses 
WHERE NOT (personality ? 'description' AND personality ? 'traits' AND personality ? 'perfume_type')
UNION ALL
SELECT id, 'perfumes' as field, perfumes 
FROM analyses 
WHERE jsonb_typeof(perfumes) != 'array' OR jsonb_array_length(perfumes) = 0;

-- Check table permissions
SELECT schemaname, tablename, tableowner, hasindexes, hasrules, hastriggers 
FROM pg_tables 
WHERE tablename = 'analyses';

-- Check RLS policies
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
FROM pg_policies 
WHERE tablename = 'analyses';

-- ============================================================================
-- SUCCESS CONFIRMATION
-- ============================================================================
-- If all queries above run without errors and show expected data,
-- your Supabase table is now properly configured and should work 
-- exactly like your "My Analyses" page in the app!
-- ============================================================================