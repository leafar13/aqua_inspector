import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onAnimationComplete;

  const SplashScreen({Key? key, required this.onAnimationComplete}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _textController;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _textScale;
  late Animation<double> _textOpacity;
  late Animation<double> _backgroundOpacity;
  late Animation<Color?> _backgroundColorTransition;

  @override
  void initState() {
    super.initState();

    // Controlador principal para el logo
    _controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    // Controlador para el texto
    _textController = AnimationController(duration: const Duration(milliseconds: 2500), vsync: this);

    // Animación de escala del logo (aparece gradualmente)
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
      ),
    );

    // Animación de opacidad del logo
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    // Animación de escala del texto (350 → 220: scale = 220/350 ≈ 0.63)
    _textScale = Tween<double>(begin: 1.0, end: 0.63).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    // Animación de opacidad del texto (desaparece al final)
    _textOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
      ),
    );

    // Animación de opacidad del fondo
    _backgroundOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    // Animación de transición de color del fondo hacia el color del AppBar
    _backgroundColorTransition =
        ColorTween(
          begin: const Color(0xFFE8F4FD), // Color inicial del splash
          end: const Color.fromARGB(255, 119, 178, 226), // Color del AppBar
        ).animate(
          CurvedAnimation(
            parent: _textController,
            curve: const Interval(0.6, 0.9, curve: Curves.easeInOut),
          ),
        );

    // Iniciar animaciones
    _startAnimations();
  }

  void _startAnimations() async {
    // Iniciar animación del logo
    await _controller.forward();

    // Esperar un poco antes de mover el texto
    await Future.delayed(const Duration(milliseconds: 500));

    // Iniciar animación del texto
    await _textController.forward();

    // Llamar callback cuando termine
    widget.onAnimationComplete();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_controller, _textController]),
        builder: (context, child) {
          return Stack(
            children: [
              // Fondo final sólido (color del AppBar)
              Container(color: const Color.fromARGB(255, 119, 178, 226)),

              // Fondo holográfico con transición de color
              AnimatedBuilder(
                animation: Listenable.merge([_backgroundOpacity, _backgroundColorTransition]),
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_backgroundColorTransition.value ?? const Color(0xFFE8F4FD), const Color(0xFFF0F8FF), const Color(0xFFE1F5FE)],
                      ),
                    ),
                    child: Opacity(
                      opacity: _backgroundOpacity.value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: const Alignment(0.3, -0.5),
                            radius: 1.5,
                            colors: [Colors.transparent, Colors.blue.withAlpha((0.05 * 255).toInt()), Colors.cyan.withAlpha((0.1 * 255).toInt())],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Patrón de ondas holográfico
              AnimatedBuilder(
                animation: _backgroundOpacity,
                builder: (context, child) {
                  return Opacity(
                    opacity: _backgroundOpacity.value * 0.3,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color(0x330000FF), // Azul con opacidad
                            Color(0x3300FFFF), // Cyan con opacidad
                            Color(0x33008080), // Teal con opacidad
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Contenido principal
              // Logo centrado
              Center(
                child: AnimatedBuilder(
                  animation: _logoOpacity,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _logoOpacity.value,
                      child: Transform.scale(
                        scale: _logoScale.value,
                        child: Hero(tag: 'logo', child: const AquaInspectorLogo(size: 300)),
                      ),
                    );
                  },
                ),
              ),

              // Texto con animación de posición absoluta
              AnimatedBuilder(
                animation: _textController,
                builder: (context, child) {
                  final screenSize = MediaQuery.of(context).size;

                  // Usar un tamaño de contenedor fijo para mantener el centrado
                  const imageWidth = 350.0;

                  // Calcular posición inicial (centro de la pantalla)
                  final initialTop = (screenSize.height / 2) + 160; // Debajo del logo
                  final initialLeft = (screenSize.width - imageWidth) / 2; // Centrado horizontalmente

                  // Calcular posición final EXACTA del AppBar
                  final statusBarHeight = MediaQuery.of(context).padding.top;
                  final appBarHeight = AppBar().preferredSize.height;
                  final finalTop = statusBarHeight + (appBarHeight / 2) - 25; // Centro del AppBar (ajustado)
                  final finalLeft = (screenSize.width - imageWidth) / 2; // Mantener centrado

                  print('📍 StatusBar: $statusBarHeight, AppBar: $appBarHeight, FinalTop: $finalTop');

                  // Interpolar entre posición inicial y final
                  final currentTop = Tween<double>(begin: initialTop, end: finalTop).transform(_textController.value);

                  final currentLeft = Tween<double>(begin: initialLeft, end: finalLeft).transform(_textController.value);

                  return Positioned(
                    top: currentTop,
                    left: currentLeft,
                    child: Transform.scale(
                      scale: _textScale.value,
                      child: SizedBox(
                        width: imageWidth, // Tamaño inicial consistente
                        child: Hero(
                          tag: 'logoText',
                          child: Image.asset('assets/images/texto.png', fit: BoxFit.contain),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

// Widget personalizado para el logo de AquaInspector
class AquaInspectorLogo extends StatelessWidget {
  final double size;

  const AquaInspectorLogo({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
    );
  }
}
