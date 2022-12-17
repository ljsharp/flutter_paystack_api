import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_paystack_api/utils/enums.dart';

final _stateChannel =
    StateProvider.autoDispose<Channel>((ref) => Channel.mobile_money);

class PaymentMethod extends ConsumerWidget {
  final ValueChanged<Channel> onChannelSeleted;
  const PaymentMethod({super.key, required this.onChannelSeleted});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(_stateChannel);
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "Choose a payment method",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                channelWidget(
                  context,
                  ref,
                  Channel.mobile_money,
                  channel == Channel.mobile_money
                      ? Colors.green
                      : Colors.transparent,
                ),
                channelWidget(
                  context,
                  ref,
                  Channel.card,
                  channel == Channel.card ? Colors.green : Colors.transparent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell channelWidget(
    BuildContext context,
    WidgetRef ref,
    Channel channel,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        onChannelSeleted(channel);
        ref.read(_stateChannel.notifier).update((state) => channel);
      },
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            channel.name.split("_").join(" ").toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
