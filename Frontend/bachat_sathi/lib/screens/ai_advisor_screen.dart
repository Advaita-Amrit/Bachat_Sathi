import 'package:flutter/material.dart';

// A model for a single chat message
class ChatMessage {
  final String text;
  final bool isUser;
  final bool isTyping;

  ChatMessage({required this.text, this.isUser = false, this.isTyping = false});
}

class AiAdvisorScreen extends StatefulWidget {
  const AiAdvisorScreen({super.key});

  @override
  State<AiAdvisorScreen> createState() => _AiAdvisorScreenState();
}

class _AiAdvisorScreenState extends State<AiAdvisorScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "Hi! I'm your personal financial advisor. Ask me anything about your finances.",
    ),
  ];

  void _handleSubmitted(String text) {
    _textController.clear();
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
      _messages.insert(
        0,
        ChatMessage(text: "...", isTyping: true),
      ); // Simulate typing
    });

    // Simulate AI response after a short delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      _aiResponse(text);
    });
  }

  void _aiResponse(String query) {
    String responseText =
        "I'm sorry, I can only respond to a few predefined questions right now.";
    if (query.toLowerCase().contains("food last week")) {
      responseText =
          "You spent ₹2,150 on food last week. The biggest expense was a ₹980 dinner at 'The Great Eatery'.";
    } else if (query.toLowerCase().contains("afford a new phone")) {
      responseText =
          "Based on your current savings rate, you can afford a ₹20,000 phone in about 3 months. Would you like to set this as a savings goal?";
    } else if (query.toLowerCase().contains("biggest expense")) {
      responseText =
          "Your biggest expense category this month is 'Bills', making up 45% of your total spending.";
    }

    setState(() {
      _messages.removeAt(0); // Remove typing indicator
      _messages.insert(0, ChatMessage(text: responseText));
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Advisor'),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ChatBubble(message: message);
              },
            ),
          ),
          _buildPromptButtons(),
          _buildTextComposer(theme),
        ],
      ),
    );
  }

  // Widget for the suggested prompt buttons
  Widget _buildPromptButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Row(
        children: [
          _promptButton("How much did I spend on food last week?"),
          _promptButton("Can I afford a new phone worth ₹20,000?"),
          _promptButton("What's my biggest expense category?"),
        ],
      ),
    );
  }

  Widget _promptButton(String text) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: OutlinedButton(
        onPressed: () => _handleSubmitted(text),
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.secondary,
          side: BorderSide(color: Theme.of(context).colorScheme.secondary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  // Widget for the text input field and send button
  Widget _buildTextComposer(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      color: const Color(0xFF1E1E1E),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: 'Ask me anything...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: theme.colorScheme.primary),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

// A reusable widget for displaying a chat message bubble
class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: message.isUser
                  ? theme.colorScheme.primary
                  : const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: message.isTyping
                ? const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    message.text,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
          ),
        ],
      ),
    );
  }
}
