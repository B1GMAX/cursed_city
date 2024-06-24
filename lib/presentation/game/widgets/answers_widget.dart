import 'package:flutter/cupertino.dart';

import 'answer_widget.dart';

class AnswersWidget extends StatelessWidget {
  const AnswersWidget({
    super.key,
    required this.storyCount,
    required this.ontTap,
  });

  final int storyCount;
  final VoidCallback ontTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/container.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (storyCount == 1) ...[
            AnswerWidget(
              text: 'Why are you here alone?',
              ontTap: ontTap,
            ),
            AnswerWidget(
              text: 'What happened to the town?',
              ontTap: ontTap,
            ),
            AnswerWidget(
              text: 'How can the curse be lifted?',
              ontTap: ontTap,
            ),
          ],
          if (storyCount == 2) ...[
            AnswerWidget(
              text: "Why can't you leave?",
              ontTap: ontTap,
            ),
            AnswerWidget(
              text: 'How do you plan to save the town?',
              ontTap: ontTap,
            ),
            AnswerWidget(
              text: 'Do you have a plan?',
              ontTap: ontTap,
            ),
          ],
          if (storyCount == 3) ...[
            AnswerWidget(
              text: 'What kind of challenges?',
              ontTap: ontTap,
            ),
            AnswerWidget(
              text: 'Show me the scroll.',
              ontTap: ontTap,
            ),
            AnswerWidget(
              text: 'How can I help you?',
              ontTap: ontTap,
            ),
          ],
          if (storyCount == 4) ...[
            AnswerWidget(
              text: "What happens if we complete them?",
              ontTap: ontTap,
            ),
            AnswerWidget(
              text: 'How did you find this scroll?',
              ontTap: ontTap,
            ),
          ],
          if (storyCount == 5) ...[
            AnswerWidget(
              text: "What's your plan afterward?",
              ontTap: ontTap,
            ),
            AnswerWidget(
              text: 'How do you cope with being here alone?',
              ontTap: ontTap,
            ),
            AnswerWidget(
              text: 'What will happen when the town is freed from the curse?',
              ontTap: ontTap,
            ),
          ],
          if (storyCount == 6) ...[
            AnswerWidget(
              text: "I'll help you. Let's lift the curse together.",
              ontTap: ontTap,
            ),
            AnswerWidget(
              text: 'This is too risky. I need to leave.',
              ontTap: ontTap,
            ),
          ],
        ],
      ),
    );
  }
}
