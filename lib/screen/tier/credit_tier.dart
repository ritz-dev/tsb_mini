import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_main/utils/localization/app_localizations.dart';
import 'package:tsb_mini/frame/button/tire_back_button.dart';
import 'package:tsb_mini/package_mode.dart';

class CarbonTierStateCard extends StatefulWidget {
  final int userPoints;

  const CarbonTierStateCard({super.key, required this.userPoints});

  @override
  State<CarbonTierStateCard> createState() => _CarbonTierStateCardState();
}

class _CarbonTierStateCardState extends State<CarbonTierStateCard> {
  late _TierData currentTier;

  @override
  void initState() {
    super.initState();
    currentTier = _getTier(widget.userPoints);
  }

  void updateTier(_TierData newTier) {
    setState(() {
      currentTier = newTier;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tier = currentTier;

    // Determine header status for the badge based on userPoints vs selected tier
    final headerStatus = widget.userPoints < tier.minPoints
        ? "LOCKED"
        : (widget.userPoints >= tier.minPoints && widget.userPoints < tier.maxPoints)
            ? "CURRENT"
            : "COMPLETED";

    String headerText;
    switch (headerStatus) {
      case "LOCKED":
        headerText = "Unlocked";
        break;
      case "CURRENT":
        headerText = "Current Tier";
        break;
      default:
        headerText = "Completed";
    }

    List<Color> bgColors;
    switch (tier.label) {
      case "BRONZE":
        bgColors = [Color(0xFFF9DEB0), Color(0xFFF9DEB0), Color(0XFFFAFAFA)];
        break;
      case "SILVER":
        bgColors = [Color(0xFFCACACA), Color(0xFFCACACA), Color(0XFFFAFAFA)];
        break;
      case "GOLD":
        bgColors = [Color(0xFFFFECB3), Color(0xFFFFECB3), Color(0XFFFAFAFA)];
        break;
      case "DIAMOND":
        bgColors = [Color(0xFFE0F2FE), Color(0xFFFAFAFA), Color(0XFFFAFAFA)];
        break;
      default:
        bgColors = [Colors.white, Colors.white];
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: bgColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 70),
            child: Column(
              children: [
                _TierBadge(asset: tier.badgeAsset, label: tier.label),
                const SizedBox(height: 6),
                Text(
                  headerText,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: const Color(0xFF7C6A53),
                  ),
                ),
                const SizedBox(height: 8),

                // Scrollable Info Section (Replaced)
                TierInfoSection(
                  currentPoints: widget.userPoints,
                  onTierChanged: (selectedTier) {
                    updateTier(_getTierByLabel(selectedTier));
                  },
                ),

                const SizedBox(height: 20),
                const _TierInfoDescriptionCard(),
              ],
            ),
          ),

          Positioned(
            top: 18,
            left: 20,
            child: SafeArea(
              bottom: false,
              child: TireBackButton(
                onBack: () => Navigator.of(context).pop(),
                localize: AppLocalizations.of(context)!,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _TierData _getTier(int points) {
    if (points <= 2000) return _getTierByLabel("BRONZE");
    if (points <= 5000) return _getTierByLabel("SILVER");
    if (points <= 8000) return _getTierByLabel("GOLD");
    return _getTierByLabel("DIAMOND");
  }

  _TierData _getTierByLabel(String label) {
    switch (label.toUpperCase()) {
      case "BRONZE":
        return _TierData(
          label: "BRONZE",
          badgeAsset: "assets/tier/bronze_card.png",
          color: const Color(0xFFD19C5B),
          minPoints: 0,
          maxPoints: 2000,
          benefits: [
            "10% discount on Upcycle merchandise",
            "Priority boarding on EV routes",
            "Birthday month eco-gift voucher",
            "Digital Bronze Tier badge",
          ],
        );
      case "SILVER":
        return _TierData(
          label: "SILVER",
          badgeAsset: "assets/tier/silver_card.png",
          color: const Color(0xFFD7D7D7),
          minPoints: 2000,
          maxPoints: 5000,
          benefits: [
            "15% discount on Upcycle merchandise",
            "Exclusive eco-events access",
            "Birthday month eco-gift voucher",
            "Digital Silver Tier badge",
          ],
        );
      case "GOLD":
        return _TierData(
          label: "GOLD",
          badgeAsset: "assets/tier/gold_card.png",
          color: const Color(0xFFFFD700),
          minPoints: 5000,
          maxPoints: 8000,
          benefits: [
            "20% discount on Upcycle merchandise",
            "VIP eco-events access",
            "Birthday month eco-gift voucher",
            "Digital Gold Tier badge",
          ],
        );
      default:
        return _TierData(
          label: "DIAMOND",
          badgeAsset: "assets/tier/diamond_card.png",
          color: const Color(0xFF7F7AED),
          minPoints: 8000,
          maxPoints: 999999,
          benefits: [
            "25% discount on Upcycle merchandise",
            "Premium eco-events access",
            "Birthday month eco-gift voucher",
            "Digital Diamond Tier badge",
          ],
        );
    }
  }
}

// ========== Scrollable Tier Info Section ==========

class TierInfoSection extends StatefulWidget {
  final int currentPoints;
  final Function(String tierLabel) onTierChanged;

  const TierInfoSection({
    super.key,
    required this.currentPoints,
    required this.onTierChanged,
  });

  @override
  State<TierInfoSection> createState() => _TierInfoSectionState();
}

class _TierInfoSectionState extends State<TierInfoSection> {
  late PageController _pageController;
  String selectedTier = "BRONZE";

  final List<String> tierOrder = ["BRONZE", "SILVER", "GOLD", "DIAMOND"];

  @override
  void initState() {
    super.initState();
    // start page matches selectedTier
    _pageController = PageController(
      viewportFraction: 0.86,
      initialPage: tierOrder.indexOf(selectedTier),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTierSelected(String tier) {
    setState(() => selectedTier = tier);
    widget.onTierChanged(tier);

    final index = tierOrder.indexOf(tier);
    if (index != -1) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TierProgressBar(
          currentPoints: widget.currentPoints,
          selectedTier: selectedTier,
          onTierSelected: _onTierSelected,
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 270,
          child: PageView.builder(
            controller: _pageController,
            itemCount: tierOrder.length,
            onPageChanged: (index) {
              // when swiped, update selection
              final newTier = tierOrder[index];
              if (newTier != selectedTier) {
                setState(() => selectedTier = newTier);
                widget.onTierChanged(newTier);
              }
            },
            itemBuilder: (context, index) {
              final tierLabel = tierOrder[index];
              final tierData = _getTierData(tierLabel);
              final isActive = tierLabel == selectedTier;

              return AnimatedPadding(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(
                  vertical: isActive ? 0 : 7,
                  horizontal: 8,
                ),
                child: Center(
                  // ensure card is centered in the viewport
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: _TierInfoCard(
                      tierData: tierData,
                      userPoints: widget.currentPoints,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _TierData _getTierData(String label) {
    switch (label) {
      case "SILVER":
        return _TierData(
          label: "SILVER",
          badgeAsset: "",
          color: Color(0xFFD7D7D7),
          minPoints: 2000,
          maxPoints: 5000,
          benefits: [
            "15% discount on Upcycle merchandise",
            "Exclusive eco-events access",
            "Birthday month eco-gift voucher",
            "Digital Silver Tier badge",
          ],
        );
      case "GOLD":
        return _TierData(
          label: "GOLD",
          badgeAsset: "",
          color: Color(0xFFFFD700),
          minPoints: 5000,
          maxPoints: 8000,
          benefits: [
            "20% discount on Upcycle merchandise",
            "VIP eco-events access",
            "Birthday month eco-gift voucher",
            "Digital Gold Tier badge",
          ],
        );
      case "DIAMOND":
        return _TierData(
          label: "DIAMOND",
          badgeAsset: "",
          color: Color(0xFF7F7AED),
          minPoints: 8000,
          maxPoints: 12000,
          benefits: [
            "25% discount on Upcycle merchandise",
            "Premium eco-events access",
            "Birthday month eco-gift voucher",
            "Digital Diamond Tier badge",
          ],
        );
      default:
        return _TierData(
          label: "BRONZE",
          badgeAsset: "",
          color: Color(0xFFD19C5B),
          minPoints: 0,
          maxPoints: 2000,
          benefits: [
            "10% discount on Upcycle merchandise",
            "Priority boarding on EV routes",
            "Birthday month eco-gift voucher",
            "Digital Bronze Tier badge",
          ],
        );
    }
  }
}

// ========== Tier Info Card ==========

class _TierInfoCard extends StatelessWidget {
  final _TierData tierData;
  final int userPoints;
  final bool showPointer;
  final VoidCallback? onPointerTap;

  const _TierInfoCard({
    required this.tierData,
    required this.userPoints,
    this.showPointer = false,
    this.onPointerTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine state: Locked / Current / Completed
    final status = userPoints < tierData.minPoints
        ? "LOCKED"
        : (userPoints >= tierData.minPoints && userPoints < tierData.maxPoints)
            ? "CURRENT"
            : "COMPLETED";

    String leftTitle;
    int leftPoints;
    switch (status) {
      case "LOCKED":
        leftTitle = "Unlock at";
        leftPoints = tierData.minPoints;
        break;
      case "CURRENT":
        leftTitle = "Current Tier";
        leftPoints = tierData.minPoints;
        break;
      default:
        leftTitle = "Complete";
        leftPoints = tierData.minPoints;
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Triangle pointer - only visible for active card; tappable to move forward
        if (showPointer)
          Positioned(
            top: -10,
            child: GestureDetector(
              onTap: onPointerTap,
              behavior: HitTestBehavior.translucent,
              child: CustomPaint(
                size: const Size(20, 10),
                painter: _TrianglePainter(color: Colors.white),
              ),
            ),
          ),

        // Main card
        Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          leftTitle,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "$leftPoints points",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 38, color: Colors.grey[300]),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "$userPoints points",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tierData.benefits
                        .map(
                          (b) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "• ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    b,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Custom painter for the top triangle pointer
class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


// ==========  Progress Bar ==========

class _TierProgressBar extends StatelessWidget {
  final int currentPoints;
  final String selectedTier;
  final Function(String) onTierSelected;

  const _TierProgressBar({
    required this.currentPoints,
    required this.selectedTier,
    required this.onTierSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bronzeColor = const Color(0xFFD19C5B);
    final silverColor = const Color(0xFFD7D7D7);
    final goldColor = const Color(0xFFFFD700);
    final diamondColor = const Color(0xFF7F7AED);
    final defaultConnector = const Color(0xFFF2ECDA);

    final states = [
      _TierState("BRONZE", "assets/tier/bronze1.png", bronzeColor),
      _TierState("SILVER", "assets/tier/silver2.png", silverColor),
      _TierState("GOLD", "assets/tier/gold1.png", goldColor),
      _TierState("DIAMOND", "assets/tier/diamond1.png", diamondColor),
    ];

    List<Color> connectorColors = [
      defaultConnector,
      defaultConnector,
      defaultConnector,
    ];

    switch (selectedTier.toUpperCase()) {
      case "BRONZE":
        connectorColors[0] = bronzeColor;
        break;
      case "SILVER":
        connectorColors[0] = bronzeColor;
        connectorColors[1] = silverColor;
        break;
      case "GOLD":
        connectorColors[0] = bronzeColor;
        connectorColors[1] = goldColor;
        break;
      case "DIAMOND":
        connectorColors = [bronzeColor, goldColor, diamondColor];
        break;
    }

    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(states.length, (index) {
          final state = states[index];
          final isSelected = selectedTier.toUpperCase() == state.name;
          return Row(
            children: [
              GestureDetector(
                onTap: () => onTierSelected(state.name),
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? state.color.withOpacity(0.15) : null,
                    border: Border.all(color: state.color, width: 2),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(state.iconAsset),
                ),
              ),
              if (index < states.length - 1)
                Container(width: 50, height: 3, color: connectorColors[index]),
            ],
          );
        }),
      ),
    );
  }
}

// Models and misc widgets

class _TierState {
  final String name;
  final String iconAsset;
  final Color color;

  _TierState(this.name, this.iconAsset, this.color);
}

class _TierData {
  final String label;
  final String badgeAsset;
  final Color color;
  final int minPoints;
  final int maxPoints;
  final List<String> benefits;

  _TierData({
    required this.label,
    required this.badgeAsset,
    required this.color,
    this.minPoints = 0,
    this.maxPoints = 0,
    this.benefits = const [],
  });
}

class _TierBadge extends StatelessWidget {
  final String asset;
  final String label;

  const _TierBadge({required this.asset, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PackageAssets.image(asset, width: 180, height: 145),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
      ],
    );
  }
}

class _TierInfoDescriptionCard extends StatelessWidget {
  const _TierInfoDescriptionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How Do I Get Carbon Credit Points?",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "You earn Carbon Credit Points every time you choose a greener journey with Thai Smile Bus. These points reflect the amount of CO₂ you help save by traveling sustainably.",
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.4,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            "Ways to Earn",
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),

          // Bulleted list
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBullet(
                "Ride an EV Bus – Every trip you take helps reduce emissions and earns you points.",
              ),
              _buildBullet(
                "Support the Upcycle Program – Purchase or wear Thai Smile Upcycle products made from recycled materials to collect bonus points.",
              ),
              _buildBullet(
                "Refer a Friend – Invite your friends to ride Thai Smile Buses and earn extra points when they join the movement.",
              ),
              _buildBullet(
                "Complete Monthly Challenges – Participate in eco-missions and unlock bonuses and multipliers.",
              ),
              _buildBullet(
                "Special Promotions – Watch out for seasonal events with limited-time multipliers and rewards.",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 14)),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
