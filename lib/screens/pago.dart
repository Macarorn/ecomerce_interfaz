import 'package:flutter/material.dart';
import 'payment.dart';

class PagoPage extends StatelessWidget {
  const PagoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Detalles del pedido",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),

            // --------------------------------------------------
            //   PRODUCTOS
            // --------------------------------------------------
            const Text(
              "Productos",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _productCard(
              imageUrl: "https://i.imgur.com/5M0Yx0P.png",
              liked: true,
            ),
            const SizedBox(height: 14),
            _productCard(
              imageUrl: "https://i.imgur.com/d2E0n8O.png",
              liked: false,
            ),

            const SizedBox(height: 28),

            // --------------------------------------------------
            //   DETALLES DE ENVÍO
            // --------------------------------------------------
            const Text(
              "Detalles de envío",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            _infoTile("Fecha de envío", "16 Enero, 2015"),
            _infoTile("Método de envío", "POS Regular"),
            _infoTile("Número de guía", "000192848573"),
            _infoTile("Dirección",
                "2727 Lakeshore Rd\nundefined Nampa,\nTennessee 78410"),

            const SizedBox(height: 28),

            // --------------------------------------------------
            //   DETALLES DE PAGO
            // --------------------------------------------------
            const Text(
              "Detalles de pago",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            _paymentRow("Artículos (3)", "\$598.86"),
            _paymentRow("Envío", "\$40.00"),
            _paymentRow("Impuestos/Importación", "\$128.00"),

            const Divider(height: 30),

            _paymentRow("Precio total", "\$766.86", bold: true),

            const SizedBox(height: 30),

            // --------------------------------------------------
            //  BOTÓN
            // --------------------------------------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4DB7F2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "pagar ahora",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  //   PRODUCT CARD
  // ==========================================================
  Widget _productCard({
    required String imageUrl,
    required bool liked,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              "Nike Air Zoom Pegasus\n36 Miami",
              style: TextStyle(
                fontSize: 15,
                height: 1.3,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$299.43",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 6),
              Icon(
                liked ? Icons.favorite : Icons.favorite_border,
                color: liked ? Colors.red : Colors.grey,
              ),
            ],
          )
        ],
      ),
    );
  }

  // ==========================================================
  //   SHIPPING DETAILS
  // ==========================================================
  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              height: 1.4,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  //   PAYMENT ROW
  // ==========================================================
  Widget _paymentRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: bold ? 16 : 15,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
