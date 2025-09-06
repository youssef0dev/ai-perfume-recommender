# AI Perfume Recommender 🌸

An intelligent perfume recommendation app that uses advanced AI facial analysis and personality recognition to suggest personalized fragrances. Built with Flutter, powered by Google's Gemini Vision API, and backed by Supabase for data persistence.

## ✨ Features

### 🤖 AI-Powered Analysis
- **Facial Recognition**: Uses Google Gemini Vision API to analyze facial features
- **Personality Assessment**: Derives personality traits from facial characteristics  
- **Smart Recommendations**: Suggests perfumes based on AI-analyzed personality profile

### 📱 Modern Flutter UI
- **Intuitive Interface**: Clean, user-friendly design with smooth animations
- **Image Capture**: Built-in camera integration for real-time photo capture
- **Responsive Design**: Optimized for various screen sizes and orientations

### 💾 Data Management
- **Supabase Integration**: Secure cloud database for storing analyses
- **My Analyses**: View history of all previous perfume recommendations
- **Real-time Sync**: Automatic saving and retrieval of user data
- **Data Export**: Easy access to recommendation history

### 🧪 Advanced Recommendation Engine
- **Multi-factor Analysis**: Considers personality traits, preferences, and facial features
- **Curated Database**: Extensive perfume catalog with detailed descriptions
- **Brand Integration**: Recommendations from top fragrance houses
- **Purchase Links**: Direct links to buy recommended perfumes

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Dart SDK (3.0+)
- Android Studio or VS Code
- Google Gemini API key
- Supabase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/youssef0dev/ai-perfume-recommender.git
   cd ai-perfume-recommender
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Environment Setup**
   - Copy `.env.template` to `.env`
   - Add your API keys:
     ```
     GEMINI_API_KEY=your_gemini_api_key_here
     SUPABASE_URL=your_supabase_url
     SUPABASE_ANON_KEY=your_supabase_anon_key
     ```

4. **Supabase Database Setup**
   - Run the provided SQL script `fix_supabase_table.sql` in your Supabase SQL editor
   - This creates the necessary tables with proper structure and sample data

5. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Architecture

### Project Structure
```
lib/
├── models/           # Data models (User, Perfume, Analysis)
├── services/         # Business logic and API integrations
│   ├── ai_vision_service.dart      # Gemini Vision API integration
│   ├── database_service.dart       # Supabase operations
│   ├── image_storage_service.dart  # Image handling utilities
│   └── recommendation_service.dart # Core recommendation logic
├── screens/          # UI screens and pages
├── widgets/          # Reusable UI components
└── main.dart        # App entry point
```

## 🔧 Configuration

### API Keys Setup
1. **Gemini API**: Get your key from [Google AI Studio](https://makersuite.google.com/)
2. **Supabase**: Create a project at [Supabase](https://supabase.com/)

### Database Schema
The app uses a single `analyses` table with the following structure:
- `id`: Primary key (serial)
- `user_image_url`: Text (base64 image data)  
- `personality`: JSONB (traits and descriptions)
- `perfumes`: JSONB array (recommended perfumes)
- `created_at`: Timestamp with timezone

## 🎯 Usage

### Quick Recommendation
1. Open the app and tap "Quick Recommendation"
2. Allow camera permissions
3. Take a selfie or select from gallery  
4. View AI-generated personality analysis
5. Browse personalized perfume recommendations

### My Analyses
1. Navigate to "My Analyses" from the home menu
2. View all previous recommendations with timestamps
3. See saved images and personality profiles
4. Delete old analyses if needed

## 📦 Dependencies

### Core Dependencies
- `flutter`: UI framework
- `supabase_flutter`: Database and authentication
- `http`: API communications
- `image_picker`: Camera and gallery access
- `google_generative_ai`: Gemini AI integration

### Dev Dependencies
- `flutter_test`: Testing framework
- `flutter_lints`: Code linting rules

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Google Gemini API for AI-powered facial analysis
- Supabase for backend infrastructure
- Flutter team for the amazing framework
- The open-source community for inspiration and support

## 📞 Support

For support, email youssef0dev@example.com or create an issue in this repository.

---

**Made with ❤️ by [youssef0dev](https://github.com/youssef0dev)**