import 'package:flutter/material.dart';
import 'package:financeiro_pessoal/app/infra/constants.dart';

class LoginScaffold extends StatelessWidget {
  final List<Widget> scaffoldChildren;
  const LoginScaffold({super.key, required this.scaffoldChildren});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.4, 0.7, 0.9],
            colors: [
              Colors.blue.shade900,
              Colors.blueGrey,
              Colors.grey.shade700,
              Colors.blue.shade900,
            ],
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.red.withOpacity(0.2), BlendMode.dstATop),
            image: Image.asset(
              Constants.backgroundImage,
            ).image,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: scaffoldChildren,
            ),
          ),
        ),
      ),
    );
  }
}
