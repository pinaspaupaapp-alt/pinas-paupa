import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const PinasPaupaApp());

class PinasPaupaApp extends StatelessWidget {
  const PinasPaupaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pinas Paupa',
      theme: ThemeData(
        primaryColor: const Color(0xFF0A7A3D),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0A7A3D)),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A7A3D),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.account_balance_wallet, size: 80, color: Color(0xFF0A7A3D)),
          ),
          const SizedBox(height: 20),
          Text('PINAS PAUPA', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          Text('Pinoy Pawnshop App', style: GoogleFonts.poppins(color: Colors.white70)),
        ]),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final phoneCtrl = TextEditingController(text: '9214869868');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 60),
          Text('Welcome Boss! 👋', style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold)),
          Text('Login to Pinas Paupa', style: GoogleFonts.poppins(color: Colors.grey)),
          const SizedBox(height: 40),
          TextField(
            controller: phoneCtrl,
            decoration: InputDecoration(labelText: 'Mobile Number', prefixText: '+63 ', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity, height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A7A3D)),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(phone: phoneCtrl.text))),
              child: Text('GET OTP', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 20),
          Center(child: Text('Demo OTP: 123456', style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey))),
        ]),
      ),
    );
  }
}

class OtpScreen extends StatelessWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});
  @override
  Widget build(BuildContext context) {
    final otpCtrl = TextEditingController(text: '123456');
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          Text('Code sent to +63 $phone'),
          const SizedBox(height: 20),
          TextField(controller: otpCtrl, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 28, letterSpacing: 10, fontWeight: FontWeight.bold), decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity, height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A7A3D)),
              onPressed: () {
                if(otpCtrl.text == '123456'){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (r) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Use 123456')));
                }
              },
              child: Text('VERIFY & LOGIN', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ]),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(backgroundColor: const Color(0xFF0A7A3D), title: Text('Pinas Paupa', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: const Color(0xFF0A7A3D), borderRadius: BorderRadius.circular(16)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Available Balance', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
                Text('₱ 12,540.00', style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ]),
              const Icon(Icons.wallet, color: Colors.white, size: 30),
            ]),
          ),
          const SizedBox(height: 20),
          Text('Services', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, childAspectRatio: 1.6, mainAxisSpacing: 12, crossAxisSpacing: 12, children: [
            Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.diamond, color: Color(0xFF0A7A3D)), const Spacer(), Text('Sangla', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)), Text('Pawning', style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey))])),
            Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.payments, color: Color(0xFF0A7A3D)), const Spacer(), Text('Paupa Loan', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)), Text('Quick Loan', style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey))])),
            Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.history, color: Color(0xFF0A7A3D)), const Spacer(), Text('Transactions', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)), Text('History', style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey))])),
            Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.support_agent, color: Color(0xFF0A7A3D)), const Spacer(), Text('Support', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)), Text('Help', style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey))])),
          ]),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(selectedItemColor: const Color(0xFF0A7A3D), unselectedItemColor: Colors.grey, type: BottomNavigationBarType.fixed, items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Paupa'),
        BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ]),
    );
  }
}
