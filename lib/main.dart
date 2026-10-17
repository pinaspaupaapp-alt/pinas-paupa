import 'package:flutter/material.dart';

void main() => runApp(const PinasPaupaApp());

// ===== GLOBAL DATA - PARA TANAN BUTTONS FUNCTIONAL =====
class AppData {
  static List<Listing> listings = [
    Listing(id: '1', title: 'Cozy Airbnb in Tizimin', category: 'Airbnb', price: 1500, host: 'Juan', photos: 3),
    Listing(id: '2', title: 'House for Rent - Cebu City', category: 'House Rent', price: 12000, host: 'Maria', photos: 5),
  ];
  static List<Listing> wishlist = [];
  static List<ChatConvo> chats = [];
  static Subscription? mySubscription;
}

class Listing {
  String id, title, category, host;
  int price, photos;
  Listing({required this.id, required this.title, required this.category, required this.price, required this.host, required this.photos});
}

class ChatConvo {
  Listing listing;
  List<ChatMsg> msgs;
  ChatConvo({required this.listing, required this.msgs});
}
class ChatMsg { String sender, text; bool isMe; ChatMsg({required this.sender, required this.text, required this.isMe}); }

class Subscription {
  String plan; int price; String expiry; String paymentMethod;
  Subscription({required this.plan, required this.price, required this.expiry, required this.paymentMethod});
}

// ===== APP =====
class PinasPaupaApp extends StatelessWidget {
  const PinasPaupaApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'Pinas Paupa', theme: ThemeData(scaffoldBackgroundColor: Colors.white), home: const MainScaffold());
  }
}

class MainScaffold extends StatefulWidget { const MainScaffold({super.key}); @override State<MainScaffold> createState() => _MainScaffoldState(); }
class _MainScaffoldState extends State<MainScaffold> {
  int idx = 0;
  final tabs = [const HomeTab(), const WishlistTab(), const TripsTab(), const MessagesTab(), const ProfileTab()];
  @override Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[idx],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20)), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: idx, onTap: (i) => setState(() => idx = i), type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white, selectedItemColor: const Color(0xFF1A8E3E), unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.travel_explore), label: 'Explore'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlists'),
              BottomNavigationBarItem(icon: Icon(Icons.card_travel), label: 'Trips'),
              BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: 'Messages'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== HOME - EXPLORE TAB =====
class HomeTab extends StatefulWidget { const HomeTab({super.key}); @override State<HomeTab> createState() => _HomeTabState(); }
class _HomeTabState extends State<HomeTab> {
  String search = '';
  @override Widget build(BuildContext context) {
    final filtered = AppData.listings.where((l) => l.title.toLowerCase().contains(search.toLowerCase()) || l.category.toLowerCase().contains(search.toLowerCase())).toList();
    return SafeArea(
      child: Column(children: [
        Container(
          color: const Color(0xFF1A8E3E),
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Row(children: [Text('Pinas Paupa ', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)), Text('🇵🇭', style: TextStyle(fontSize: 20))]),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF1A8E3E), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterAndUploadPage())).then((_) => setState(() {})),
              child: const Text('Register', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ]),
        ),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(decoration: BoxDecoration(color: const Color(0xFF1A8E3E), borderRadius: BorderRadius.circular(16)), child: TextField(onChanged: (v) => setState(() => search = v), decoration: const InputDecoration(hintText: 'Search Airbnb, House, Lot, Services...', hintStyle: TextStyle(color: Colors.white70), prefixIcon: Icon(Icons.search, color: Colors.white), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)), style: const TextStyle(color: Colors.white))),
          const SizedBox(height: 18),
          const Text('Category', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, childAspectRatio: 2.7, mainAxisSpacing: 10, crossAxisSpacing: 10, children: [
            _catBtn(context, 'Airbnb', Icons.home, const Color(0xFFFFE8E9), Colors.red),
            _catBtn(context, 'House Rent', Icons.house_siding, const Color(0xFFE8F5E9), const Color(0xFF1A8E3E)),
            _catBtn(context, 'House Sale', Icons.house, const Color(0xFFE3F2FD), Colors.blue),
            _catBtn(context, 'Lot Rent', Icons.terrain, const Color(0xFFFFF8E1), Colors.orange),
            _catBtn(context, 'Lot Sale', Icons.landscape, const Color(0xFFEFEBE9), Colors.brown),
            _catBtn(context, 'Rent Car', Icons.car_rental, const Color(0xFFF3E5F5), Colors.purple),
            _catBtn(context, 'Food', Icons.fastfood, const Color(0xFFFFEBEE), Colors.redAccent),
            _catBtn(context, 'Services', Icons.build, const Color(0xFFE0F7FA), const Color(0xFF00838F)),
          ]),
          const SizedBox(height: 20),
          const Text('Popular Services', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(spacing: 12, runSpacing: 12, children: [
            _serviceChip('Aircon', Icons.ac_unit), _serviceChip('Cleaning', Icons.cleaning_services), _serviceChip('Tubero', Icons.plumbing), _serviceChip('Renovation', Icons.handyman),
            _serviceChip('Electrical', Icons.electrical_services), _serviceChip('Transport', Icons.directions_bus), _serviceChip('Gardening', Icons.local_florist), _serviceChip('Fitness', Icons.self_improvement),
          ]),
          const SizedBox(height: 24),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Available Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text('${filtered.length} listings', style: const TextStyle(color: Colors.grey))]),
          const SizedBox(height: 10),
          ...filtered.map((l) => _listingCard(context, l)).toList(),
        ]))),
      ]),
    );
  }
  Widget _catBtn(BuildContext ctx, String title, IconData icon, Color bg, Color ic) {
    return InkWell(onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => RegisterAndUploadPage(preselectedCategory: title))).then((_) => setState(() {})), child: Container(decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.black12)), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: ic, size: 22), const SizedBox(width: 8), Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))]))); 
  }
  Widget _serviceChip(String label, IconData icon) => SizedBox(width: 75, child: Column(children: [Container(width: 60, height: 60, decoration: const BoxDecoration(color: Color(0xFFEEF6F6), shape: BoxShape.circle), child: Icon(icon, color: const Color(0xFF1A8E3E))), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center)]));
  Widget _listingCard(BuildContext ctx, Listing l) {
    return Card(margin: const EdgeInsets.only(bottom: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: ListTile(
      leading: Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)), child: Icon(Icons.image, color: Colors.grey[600])),
      title: Text(l.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text('${l.category} • ₱${l.price} • ${l.photos} photos • Host: ${l.host}'),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(icon: Icon(AppData.wishlist.contains(l) ? Icons.favorite : Icons.favorite_border, color: Colors.red), onPressed: () { setState(() { if (AppData.wishlist.contains(l)) { AppData.wishlist.remove(l); } else { AppData.wishlist.add(l); } }); }),
        IconButton(icon: const Icon(Icons.message, color: Color(0xFF1A8E3E)), onPressed: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => ChatDetailPage(listing: l)))),
      ]),
      onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => ListingDetailPage(listing: l))),
    ));
  }
}

// ===== REGISTER + UPLOAD PICTURE + SUBSCRIPTION YEARLY =====
class RegisterAndUploadPage extends StatefulWidget {
  final String? preselectedCategory;
  const RegisterAndUploadPage({super.key, this.preselectedCategory});
  @override State<RegisterAndUploadPage> createState() => _RegisterAndUploadPageState();
}
class _RegisterAndUploadPageState extends State<RegisterAndUploadPage> {
  int step = 0;
  String category = 'Airbnb';
  String title = '', desc = '', price = '';
  int photoCount = 0;
  String selectedPlan = 'Pro - ₱1,999/year';
  int planPrice = 1999;
  String paymentMethod = 'GCash';

  @override void initState() { super.initState(); if (widget.preselectedCategory != null) category = widget.preselectedCategory!; }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Host Registration - Airbnb Style'), backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: Stepper(
        currentStep: step,
        onStepContinue: () {
          if (step < 4) { setState(() => step++); } else { _publish(); }
        },
        onStepCancel: () { if (step > 0) setState(() => step--); },
        steps: [
          Step(title: const Text('Category'), content: DropdownButtonFormField<String>(value: category, items: ['Airbnb','House Rent','House Sale','Lot Rent','Lot Sale','Rent Car','Food','Services'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => category = v!))),
          Step(title: const Text('Listing Details'), content: Column(children: [
            TextField(decoration: const InputDecoration(labelText: 'Title (ex: Cozy House in Tizimin)', border: OutlineInputBorder()), onChanged: (v) => title = v),
            const SizedBox(height: 10),
            TextField(decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()), maxLines: 3, onChanged: (v) => desc = v),
            const SizedBox(height: 10),
            TextField(decoration: const InputDecoration(labelText: 'Price per night/month ₱', border: OutlineInputBorder()), keyboardType: TextInputType.number, onChanged: (v) => price = v),
          ])),
          Step(title: const Text('Upload Pictures'), content: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Maka upload picture - pindutin ang + para mag add (simulated upload)', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 10),
            GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: photoCount + 1, itemBuilder: (ctx, i) {
              if (i == photoCount) {
                return InkWell(onTap: () => setState(() => photoCount++), child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.add_a_photo, size: 30, color: Colors.grey)));
              }
              return Container(decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)), child: Stack(children: [Center(child: Icon(Icons.image, color: Colors.grey[600])), Positioned(top: 2, right: 2, child: InkWell(onTap: () => setState(() => photoCount--), child: const Icon(Icons.close, size: 18, color: Colors.red)))]));
            }),
            const SizedBox(height: 8),
            Text('$photoCount photos uploaded', style: const TextStyle(fontWeight: FontWeight.bold)),
          ])),
          Step(title: const Text('Subscription - Yearly'), content: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Bayad sila subscription yearly kung mo register sa apps', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A8E3E))),
            const SizedBox(height: 12),
            ...[
              {'name': 'Basic - ₱999/year', 'price': 999, 'desc': '3 listings, chat with guests'},
              {'name': 'Pro - ₱1,999/year', 'price': 1999, 'desc': 'Unlimited listings, featured, chat, upload 20 photos'},
              {'name': 'Business - ₱3,999/year', 'price': 3999, 'desc': 'Unlimited + Priority + Analytics'},
            ].map((p) => RadioListTile<String>(title: Text(p['name'] as String), subtitle: Text(p['desc'] as String), value: p['name'] as String, groupValue: selectedPlan, activeColor: const Color(0xFF1A8E3E), onChanged: (v) => setState(() { selectedPlan = v!; planPrice = p['price'] as int; }))),
            const Divider(),
            const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(value: paymentMethod, items: ['GCash','GoTyme','Bank Transfer','Credit Card'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => paymentMethod = v!)),
            const SizedBox(height: 10),
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(8)), child: Text('Total: ₱$planPrice / year\nAuto-renew yearly. Cancel anytime in Settings.', style: const TextStyle(fontWeight: FontWeight.bold))),
          ])),
          Step(title: const Text('Confirm & Publish'), content: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Category: $category'), Text('Title: $title'), Text('Price: ₱$price'), Text('Photos: $photoCount'), const Divider(), Text('Plan: $selectedPlan'), Text('Payment: $paymentMethod'), const SizedBox(height: 12), const Text('Pindutin ang Publish para mag upload!', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ])),
        ],
      ),
    );
  }

  void _publish() {
    if (title.isEmpty) title = 'New Listing in ${category}';
    final newListing = Listing(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title, category: category, price: int.tryParse(price) ?? 1000, host: 'You', photos: photoCount == 0 ? 1 : photoCount);
    AppData.listings.insert(0, newListing);
    AppData.mySubscription = Subscription(plan: selectedPlan, price: planPrice, expiry: 'Oct 17, 2027', paymentMethod: paymentMethod);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success! ${newListing.title} published with $selectedPlan')));
    Navigator.pop(context);
  }
}

// ===== LISTING DETAIL WITH CHAT BUTTON =====
class ListingDetailPage extends StatelessWidget {
  final Listing listing;
  const ListingDetailPage({super.key, required this.listing});
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(listing.title), backgroundColor: Colors.white, foregroundColor: Colors.black),
      body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(height: 200, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.collections, size: 50, color: Colors.grey[500]), Text('${listing.photos} photos uploaded - Maka upload picture', style: TextStyle(color: Colors.grey[600]))]))),
        const SizedBox(height: 16),
        Text(listing.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text('${listing.category} • ₱${listing.price}/night • Host: ${listing.host}', style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 16),
        const Text('Pwede maka chat sa mga guest - lahat ng button function!', style: TextStyle(color: Color(0xFF1A8E3E))),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A8E3E)), icon: const Icon(Icons.message, color: Colors.white), label: const Text('Chat with Host', style: TextStyle(color: Colors.white)), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatDetailPage(listing: listing))))),
          const SizedBox(width: 10),
          Expanded(child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor: Colors.white, side: const BorderSide(color: Color(0xFF1A8E3E))), icon: const Icon(Icons.favorite_border, color: Color(0xFF1A8E3E)), label: const Text('Wishlist', style: TextStyle(color: Color(0xFF1A8E3E))), onPressed: () { AppData.wishlist.add(listing); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to Wishlist!'))); })),
        ]),
      ])),
    );
  }
}

// ===== CHAT FUNCTIONAL =====
class ChatDetailPage extends StatefulWidget { final Listing listing; const ChatDetailPage({super.key, required this.listing}); @override State<ChatDetailPage> createState() => _ChatDetailPageState(); }
class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController ctrl = TextEditingController();
  List<ChatMsg> messages = [ChatMsg(sender: 'Host', text: 'Hello! Interested in ${'listing'}?', isMe: false), ChatMsg(sender: 'You', text: 'Yes, maka chat ta diri?', isMe: true)];
  @override void initState() { super.initState(); messages[0] = ChatMsg(sender: widget.listing.host, text: 'Hello! Interested in ${widget.listing.title}? Maka upload picture ug maka chat ta diri.', isMe: false); }
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat - ${widget.listing.host}'), backgroundColor: Colors.white, foregroundColor: Colors.black, actions: [IconButton(icon: const Icon(Icons.image), onPressed: () { setState(() => messages.add(ChatMsg(sender: 'You', text: '[Photo uploaded 📸]', isMe: true))); })]),
      body: Column(children: [
        Expanded(child: ListView.builder(padding: const EdgeInsets.all(12), itemCount: messages.length, itemBuilder: (ctx, i) {
          final m = messages[i];
          return Align(alignment: m.isMe ? Alignment.centerRight : Alignment.centerLeft, child: Container(margin: const EdgeInsets.symmetric(vertical: 4), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: m.isMe ? const Color(0xFF1A8E3E) : Colors.grey[200], borderRadius: BorderRadius.circular(16)), child: Text(m.text, style: TextStyle(color: m.isMe ? Colors.white : Colors.black))));
        })),
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]), child: Row(children: [
          IconButton(icon: const Icon(Icons.add_a_photo, color: Color(0xFF1A8E3E)), onPressed: () => setState(() => messages.add(ChatMsg(sender: 'You', text: '[📸 Photo: ${widget.listing.title}]', isMe: true)))),
          Expanded(child: TextField(controller: ctrl, decoration: const InputDecoration(hintText: 'Maka chats sa mga guest...', border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))))),
          IconButton(icon: const Icon(Icons.send, color: Color(0xFF1A8E3E)), onPressed: () { if (ctrl.text.isNotEmpty) { setState(() { messages.add(ChatMsg(sender: 'You', text: ctrl.text, isMe: true)); ctrl.clear(); }); Future.delayed(const Duration(seconds: 1), () { if (mounted) setState(() => messages.add(ChatMsg(sender: widget.listing.host, text: 'Sige boss, reply ko taod-taod!', isMe: false))); }); } }),
        ])),
      ]),
    );
  }
}

// ===== OTHER TABS =====
class WishlistTab extends StatefulWidget { const WishlistTab({super.key}); @override State<WishlistTab> createState() => _WishlistTabState(); }
class _WishlistTabState extends State<WishlistTab> { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Wishlists'), backgroundColor: Colors.white, foregroundColor: Colors.black), body: AppData.wishlist.isEmpty ? const Center(child: Text('No wishlist yet - tap heart sa listing!')) : ListView.builder(itemCount: AppData.wishlist.length, itemBuilder: (ctx, i) { final l = AppData.wishlist[i]; return ListTile(title: Text(l.title), subtitle: Text(l.category), trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => setState(() => AppData.wishlist.removeAt(i)))); })); }
class TripsTab extends StatelessWidget { const TripsTab({super.key}); @override Widget build(BuildContext context) => Scaffold(body: SafeArea(child: Column(children: [Expanded(child: Container(color: const Color(0xFFD6EAF8), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.map, size: 80, color: Colors.blueGrey), const SizedBox(height: 12), Text('${AppData.listings.length} listings map out your next trip', style: const TextStyle(fontWeight: FontWeight.bold)), const Text('Tap listing para maka chat sa guest', style: TextStyle(color: Colors.grey))])))), Container(padding: const EdgeInsets.all(16), child: const Text('Map out your next trip - After you book, come back here to see details, explore map, and save places.', textAlign: TextAlign.center))]))); }
class MessagesTab extends StatefulWidget { const MessagesTab({super.key}); @override State<MessagesTab> createState() => _MessagesTabState(); }
class _MessagesTabState extends State<MessagesTab> { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Messages - Maka chats'), backgroundColor: Colors.white, foregroundColor: Colors.black), body: AppData.chats.isEmpty && AppData.listings.isNotEmpty ? ListView.builder(itemCount: AppData.listings.length, itemBuilder: (ctx, i) { final l = AppData.listings[i]; return ListTile(leading: CircleAvatar(backgroundColor: const Color(0xFF1A8E3E), child: Text(l.host[0])), title: Text('Chat with ${l.host} - ${l.title}'), subtitle: const Text('Maka chats sa mga guest - tap to chat'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => ChatDetailPage(listing: l)))); }) : const Center(child: Text('No messages - Mag chat sa listing para maka connect sa host'))); }

// ===== PROFILE WITH SETTINGS FOR REGISTRATION & YEARLY SUBSCRIPTION =====
class ProfileTab extends StatefulWidget { const ProfileTab({super.key}); @override State<ProfileTab> createState() => _ProfileTabState(); }
class _ProfileTabState extends State<ProfileTab> {
  @override Widget build(BuildContext context) {
    final sub = AppData.mySubscription;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)), backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        if (sub != null) Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF1A8E3E))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Row(children: [Icon(Icons.verified, color: Color(0xFF1A8E3E)), SizedBox(width: 8), Text('Active Subscription', style: TextStyle(fontWeight: FontWeight.bold))]), const SizedBox(height: 8), Text('Plan: ${sub.plan}'), Text('Price: ₱${sub.price}/year'), Text('Expiry: ${sub.expiry}'), Text('Payment: ${sub.paymentMethod}'), const SizedBox(height: 8), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A8E3E)), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionSettingsPage())).then((_) => setState(() {})), child: const Text('Manage Subscription', style: TextStyle(color: Colors.white)))])),
        const SizedBox(height: 12),
        ListTile(leading: const Icon(Icons.settings), title: const Text('Account settings - Registration'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountSettingsPage()))),
        ListTile(leading: const Icon(Icons.card_membership, color: Color(0xFF1A8E3E)), title: const Text('Subscription & Yearly Payment'), subtitle: Text(sub == null ? 'Wala pa - Mag Register para maka upload' : '${sub.plan} - Active'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionSettingsPage())).then((_) => setState(() {}))),
        ListTile(leading: const Icon(Icons.photo_library), title: const Text('My Listings - Maka upload picture'), subtitle: Text('${AppData.listings.length} listings'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyListingsPage()))),
        ListTile(leading: const Icon(Icons.message), title: const Text('Messages - Maka chats sa guest'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MessagesTab()))),
        const Divider(),
        ListTile(leading: const Icon(Icons.help_outline), title: const Text('Get help'), trailing: const Icon(Icons.chevron_right)),
        ListTile(leading: const Icon(Icons.person_outline), title: const Text('View profile'), trailing: const Icon(Icons.chevron_right)),
        ListTile(leading: const Icon(Icons.privacy_tip_outlined), title: const Text('Privacy'), trailing: const Icon(Icons.chevron_right)),
        ListTile(leading: const Icon(Icons.logout), title: const Text('Log out')),
      ]),
    );
  }
}

class AccountSettingsPage extends StatelessWidget { const AccountSettingsPage({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Account Settings - Registration')), body: ListView(padding: const EdgeInsets.all(16), children: const [TextField(decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())), SizedBox(height: 12), TextField(decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder())), SizedBox(height: 12), TextField(decoration: InputDecoration(labelText: 'Phone', border: OutlineInputBorder())), SizedBox(height: 20), Text('Maka register sila para upload sa mga picture nila - Lahat ng button function!', style: TextStyle(color: Colors.grey))]))); }

class SubscriptionSettingsPage extends StatefulWidget { const SubscriptionSettingsPage({super.key}); @override State<SubscriptionSettingsPage> createState() => _SubscriptionSettingsPageState(); }
class _SubscriptionSettingsPageState extends State<SubscriptionSettingsPage> {
  String selectedPayment = 'GCash';
  @override Widget build(BuildContext context) {
    final sub = AppData.mySubscription;
    return Scaffold(
      appBar: AppBar(title: const Text('Subscription Settings')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        const Text('Settings para sa registration og bayad sila subscription yearly kung mo register sila sa apps', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A8E3E))),
        const SizedBox(height: 16),
        if (sub != null) ...[
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Current: ${sub.plan}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text('Price: ₱${sub.price}/year'), Text('Payment: ${sub.paymentMethod}'), Text('Expiry: ${sub.expiry}'), const SizedBox(height: 12), LinearProgressIndicator(value: 0.3, backgroundColor: Colors.grey[200], color: const Color(0xFF1A8E3E)), const SizedBox(height: 4), const Text('292 days remaining', style: TextStyle(fontSize: 12, color: Colors.grey))]))),
          const SizedBox(height: 16),
        ],
        const Text('Choose Yearly Plan:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _planCard('Basic', 999, '3 listings, chat, 5 photos per listing'),
        _planCard('Pro - BEST', 1999, 'Unlimited listings, 20 photos, chat, featured'),
        _planCard('Business', 3999, 'Unlimited + Priority support + Analytics + Verified badge'),
        const SizedBox(height: 16),
        const Text('Payment Method - Butangi sad settings para sa registration:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(value: selectedPayment, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Select Payment'), items: ['GCash','GoTyme','Bank Transfer (BPI, BDO)','Credit/Debit Card','PayMaya'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => selectedPayment = v!)),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A8E3E)), onPressed: () { setState(() { AppData.mySubscription = Subscription(plan: 'Pro - ₱1,999/year', price: 1999, expiry: 'Oct 17, 2027', paymentMethod: selectedPayment); }); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Subscription activated! Paid via $selectedPayment - Yearly'))); Navigator.pop(context); }, child: const Text('Pay Yearly Subscription - Activate', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
        const SizedBox(height: 12),
        const Text('Note: Yearly subscription required para maka upload picture ug maka chat sa guest. Lahat ng button function after subscription.', style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
      ]),
    );
  }
  Widget _planCard(String name, int price, String desc) => Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(title: Text('$name - ₱$price/year', style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(desc), trailing: AppData.mySubscription?.plan.contains(name) == true ? const Icon(Icons.check_circle, color: Color(0xFF1A8E3E)) : null));
}

class MyListingsPage extends StatefulWidget { const MyListingsPage({super.key}); @override State<MyListingsPage> createState() => _MyListingsPageState(); }
class _MyListingsPageState extends State<MyListingsPage> { @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('My Listings - Maka upload')), body: AppData.listings.isEmpty ? const Center(child: Text('Wala pa - Mag Register para maka upload picture')) : ListView.builder(itemCount: AppData.listings.length, itemBuilder: (ctx, i) { final l = AppData.listings[i]; return ListTile(leading: Container(width: 50, height: 50, color: Colors.grey[200], child: Icon(Icons.image, color: Colors.grey[600])), title: Text(l.title), subtitle: Text('${l.category} - ${l.photos} photos - ₱${l.price}'), trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () {}), IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => setState(() => AppData.listings.removeAt(i)))])); })); }
