import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/features/chat/cubit/chat_cubit.dart';
import 'package:se7ety/features/chat/widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
  });

  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(
        patientId: patientId,
        patientName: patientName,
        doctorId: doctorId,
        doctorName: doctorName,
      )..watchMessages(),
      child: _ChatView(doctorName: doctorName),
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView({required this.doctorName});

  final String doctorName;

  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _send() {
    context.read<ChatCubit>().sendMessage(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.doctorName)),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) _scrollToBottom();
              },
              builder: (context, state) {
                if (state is ChatLoading || state is ChatInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ChatFailure) {
                  return Center(child: Text(state.message));
                }
                if (state is ChatSuccess) {
                  if (state.messages.isEmpty) {
                    return const Center(child: Text('ابدأ المحادثة'));
                  }
                  final cubit = context.read<ChatCubit>();
                  return ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: state.messages.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final msg = state.messages[index];
                      return ChatBubble(
                        text: msg.text,
                        isMine: msg.senderId == cubit.currentUserId,
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          _MessageInput(controller: _controller, onSend: _send),
        ],
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintText: 'اكتب رسالة...',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.accentColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: IconButton(
                icon: const Icon(Icons.send, color: AppColors.whiteColor),
                onPressed: onSend,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
