import 'package:flutter/material.dart';

class ConsultaCard extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final DateTime fecha;
  final VoidCallback? onTap;

  const ConsultaCard({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: Theme.of(context).textTheme.titleMedium,
                textScaler: MediaQuery.textScalerOf(context),
              ),
              const SizedBox(height: 8),
              Text(
                descripcion,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textScaler: MediaQuery.textScalerOf(context),
              ),
              const SizedBox(height: 12),
              Text(
                'Fecha: ${fecha.day}/${fecha.month}/${fecha.year}',
                style: Theme.of(context).textTheme.bodySmall,
                textScaler: MediaQuery.textScalerOf(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}