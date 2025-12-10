import 'package:flutter/material.dart';

class OrdenCompraScreen extends StatelessWidget {
  const OrdenCompraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Orden',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildOrderCard(
            orderNumber: 'LQNSU346JK',
            date: 'Orden en Lafyuu : 1 de Agosto, 2017',
            status: 'Enviando',
            items: '2 artículos comprados',
            price: '\$289,43',
          ),
          const SizedBox(height: 16),
          _buildOrderCard(
            orderNumber: 'SDG1345KJD',
            date: 'Orden en Lafyuu : 1 de Agosto, 2017',
            status: 'Enviando',
            items: '1 artículo comprado',
            price: '\$289,43',
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard({
    required String orderNumber,
    required String date,
    required String status,
    required String items,
    required String price,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderNumber,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(date, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 16),
          _buildOrderRow('Estado de la Orden', status),
          const SizedBox(height: 12),
          _buildOrderRow('Artículos', items),
          const SizedBox(height: 12),
          _buildOrderRow('Precio', price, isPrice: true),
        ],
      ),
    );
  }

  Widget _buildOrderRow(String label, String value, {bool isPrice = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isPrice ? FontWeight.bold : FontWeight.normal,
            color: isPrice ? Colors.blue : Colors.black,
          ),
        ),
      ],
    );
  }
}
