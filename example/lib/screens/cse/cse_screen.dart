import 'package:adyen_checkout/adyen_checkout.dart';
import 'package:adyen_checkout_example/config.dart';
import 'package:flutter/material.dart';

class CseScreen extends StatefulWidget {
  const CseScreen({super.key});

  @override
  State<CseScreen> createState() => _CseScreenState();
}

class _CseScreenState extends State<CseScreen> {
  final String publicKey = Config.publicKey;
  final _cardInfo = {
    'cardNumber': "5555555555554444",
    'expiryMonth': "03",
    'expiryYear': "2030",
    'cvc': "737",
  };
  EncryptedCard? _encryptedCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Adyen Client-Side card encryption')),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _cardInfo.entries
                      .map((entry) => Row(
                            children: [
                              Text('${entry.key}: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(width: 8),
                              Text(entry.value),
                            ],
                          ))
                      .toList(),
                ),
                const SizedBox(height: 5),
                FilledButton(
                  onPressed: encryptCard,
                  child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Encrypt"), Icon(Icons.arrow_downward)]),
                ),
                const SizedBox(height: 5),
                const Text('encryption result:'),
                if (_encryptedCard != null)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              children: [
                                const Text('encryptedCardNumber: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(width: 8),
                                Text('${_encryptedCard!.encryptedCardNumber}'),
                              ],
                            ),
                            Wrap(
                              children: [
                                const Text('encryptedExpiryMonth: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(width: 8),
                                Text('${_encryptedCard!.encryptedExpiryMonth}'),
                              ],
                            ),
                            Wrap(
                              children: [
                                const Text('encryptedExpiryYear: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(width: 8),
                                Text('${_encryptedCard!.encryptedExpiryYear}'),
                              ],
                            ),
                            Wrap(
                              children: [
                                const Text('encryptedCvc: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(width: 8),
                                Text('${_encryptedCard!.encryptedSecurityCode}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> encryptCard() async {
    try {
      final UnencryptedCard unencryptedCard = UnencryptedCard(
        cardNumber: "5555555555554444",
        expiryMonth: "03",
        expiryYear: "2030",
        cvc: "737",
      );
      _encryptedCard = await AdyenCheckout.instance.encryptCard(unencryptedCard, publicKey);
      setState(() {});
    } catch (exception) {
      debugPrint(exception.toString());
    }
  }
}
