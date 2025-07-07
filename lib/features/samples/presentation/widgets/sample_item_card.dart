import 'package:flutter/material.dart';
import 'package:aqua_inspector/features/samples/domain/entities/sample_item.dart';
import 'package:intl/intl.dart';

class SampleItemCard extends StatelessWidget {
  final SampleItem sample;

  const SampleItemCard({
    super.key,
    required this.sample,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // TODO: Implementar navegación a detalle de muestra
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Muestra ${sample.sampleNumber}'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                _buildSampleInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sample.waterAssociationName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                sample.systemName,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            _buildSyncIcon(),
            const SizedBox(width: 12),
            _buildDateChip(),
          ],
        ),
      ],
    );
  }

  Widget _buildSyncIcon() {
    return Icon(
      Icons.cloud,
      size: 20,
      color: sample.isSynced ? Colors.green : Colors.grey[400],
    );
  }

  Widget _buildDateChip() {
    final formatter = DateFormat('dd/MM/yyyy');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        formatter.format(sample.samplingDatetime),
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildSampleInfo() {
    return Row(
      children: [
        Icon(
          Icons.science,
          size: 24,
          color: Colors.grey[400],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            sample.sampleNumber,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}