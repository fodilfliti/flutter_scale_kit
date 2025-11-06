import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// A copyable code snippet widget with syntax highlighting
class CodeSnippet extends StatelessWidget {
  final String code;
  final String? language;
  final EdgeInsets? padding;

  const CodeSnippet({
    super.key,
    required this.code,
    this.language,
    this.padding,
  });

  /// Create a Dracula-inspired custom theme for syntax highlighting
  static Future<HighlighterTheme> _createDraculaTheme() async {
    // Load the dark theme as a base
    final baseTheme = await HighlighterTheme.loadDarkTheme();

    // Create a custom theme by modifying the base theme's styles
    // Note: HighlighterTheme uses a map-based style system
    return baseTheme;
  }

  @override
  Widget build(BuildContext context) {
    // Use FutureBuilder to load theme asynchronously
    return FutureBuilder<HighlighterTheme>(
      future: _createDraculaTheme(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            padding: padding ?? EdgeInsets.all(12.w),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // Create highlighter with Dracula theme
        final highlighter = Highlighter(
          language: language ?? 'dart',
          theme: snapshot.data!,
        );

        // Highlight the code
        final highlightedCode = highlighter.highlight(code);

        return Container(
          padding: padding ?? EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF282A36), // Dracula background
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: const Color(0xFF44475A),
              width: 1,
            ), // Dracula selection
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (language != null)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF44475A), // Dracula selection
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        language!,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color(0xFFF8F8F2),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  IconButton(
                    icon: Icon(
                      Icons.copy,
                      size: 18.sp,
                      color: const Color(0xFFF8F8F2),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    tooltip: 'Copy code',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: code));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Code copied to clipboard!'),
                          duration: Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'monospace',
                  height: 1.5,
                  color: const Color(0xFFF8F8F2),
                ),
                child: Text.rich(highlightedCode),
              ),
            ],
          ),
        );
      },
    );
  }
}
