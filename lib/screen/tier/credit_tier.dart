import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/frame/button/customize_button.dart';
import 'package:tsb_mini/package_mode.dart';

class CarbonTierStateCard extends StatelessWidget {
  final int userPoints; // <-- pass the points

  const CarbonTierStateCard({super.key, required this.userPoints});

  @override
  Widget build(BuildContext context) {
    final tier = _getTier(userPoints);

    List<Color> bgColors;
    switch (tier.label) {
      case "BRONZE":
        bgColors = [
          Color(0xFFF9DEB0),
          Color(0xFFF9DEB0),
          Color(0XFFFAFAFA),
          Color(0XFFFAFAFA),
        ];
        break;
      case "SILVER":
        bgColors = [
          Color(0xFFCACACA),
          Color(0xFFCACACA),
          Color(0XFFFAFAFA),
          Color(0XFFFAFAFA),
        ];
        break;
      case "GOLD":
        bgColors = [
          Color(0xFFFFECB3),
          Color(0xFFFFECB3),
          Color(0XFFFAFAFA),
          Color(0XFFFAFAFA),
        ];
        break;
      case "DIAMOND":
        bgColors = [
          Color(0xFFE0F2FE),
          Color(0xFFFAFAFA),
          Color(0XFFFAFAFA),
          Color(0XFFFAFAFA),
        ];
        break;
      default:
        bgColors = [Colors.white, Colors.white];
    }

    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: bgColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Main content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 18),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: FrostedBackButtonBlack(
                      onBack: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),

                // Tier badge
                _TierBadge(asset: tier.badgeAsset, label: tier.label),

                Text(
                  "Completed",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: const Color(0xFF7C6A53),
                  ),
                ),

                // Progress bar with dynamic points
                _TierProgressBar(currentPoints: userPoints),

                // Info card connected to progress
                _TierInfoCard(
                  tierLabel: tier.label,
                  tierPoints: tier
                      .minPoints, // show the minimum points for current tier
                  userPoints: userPoints, // show the user's actual points
                  benefits: tier.benefits,
                ),
                _TierInfoDescriptionCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Determine which tier user belongs to
  _TierData _getTier(int points) {
    if (points <= 2000) {
      return _TierData(
        label: "BRONZE",
        badgeAsset: "assets/tier/bronze_card.png",
        color: const Color(0xFFD19C5B),
        minPoints: 0,
        maxPoints: 2000,
        benefits: [
          "10% discount on Upcycle merchandise",
          "Priority boarding on EV routes",
          "Birthday month eco-gif voucher",
          "Digital Bronze Tier badge",
        ],
      );
    } else if (points <= 5000) {
      return _TierData(
        label: "SILVER",
        badgeAsset: "assets/tier/silver_card.png",
        color: const Color(0xFFC0C0C0),
        minPoints: 2000,
        maxPoints: 5000,
        benefits: [
          "15% discount on Upcycle merchandise",
          "Exclusive eco-events access",
          "Birthday month eco-gif voucher",
          "Digital Silver Tier badge",
        ],
      );
    } else if (points <= 8000) {
      return _TierData(
        label: "GOLD",
        badgeAsset: "assets/tier/gold_card.png",
        color: const Color(0xFFFFD700),
        minPoints: 5000,
        maxPoints: 8000,
        benefits: [
          "20% discount on Upcycle merchandise",
          "VIP eco-events access",
          "Birthday month eco-gif voucher",
          "Digital Gold Tier badge",
        ],
      );
    } else {
      return _TierData(
        label: "DIAMOND",
        badgeAsset: "assets/tier/diamond_card.png",
        color: const Color(0xFFB9F2FF),
        minPoints: 8000,
        maxPoints: 12000,
        benefits: [
          "25% discount on Upcycle merchandise",
          "Premium eco-events access",
          "Birthday month eco-gif voucher",
          "Digital Diamond Tier badge",
        ],
      );
    }
  }
}

// Model for tier data
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
    required this.minPoints,
    required this.maxPoints,
    required this.benefits,
  });
}

// Badge widget
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

// Dynamic progress bar
class _TierProgressBar extends StatelessWidget {
  final int currentPoints;

  const _TierProgressBar({required this.currentPoints});

  @override
  Widget build(BuildContext context) {
    final List<_TierState> states = [
      _TierState(
        "Bronze",
        "assets/tier/bronze.png",
        0,
        2000,
        Color(0xFFD19C5B),
      ),
      _TierState(
        "Silver",
        "assets/tier/silver.png",
        2001,
        5000,
        Color(0xFFC0C0C0),
      ),
      _TierState("Gold", "assets/tier/gold.png", 5001, 8000, Color(0xFFFFD700)),
      _TierState(
        "Diamond",
        "assets/tier/diamond.png",
        8001,
        12000,
        Color(0xFFB9F2FF),
      ),
    ];

    // Find current tier index
    int currentTierIdx = states.indexWhere(
      (s) => currentPoints >= s.min && currentPoints <= s.max,
    );
    if (currentTierIdx == -1 && currentPoints > states.last.max) {
      currentTierIdx = states.length - 1;
    }

    // Calculate progress (0.0 - 1.0)
    int min = states.first.min;
    int max = states.last.max;
    double progress = ((currentPoints - min) / (max - min)).clamp(0.0, 1.0);

    return SizedBox(
      height: 80,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Triangle pointer
          // Positioned(
          //   left: 0.0 * currentTierIdx + 50.0 * currentTierIdx,
          //   top: 0,
          //   child: CustomPaint(
          //     size: const Size(30, 20),
          //     painter: _TrianglePainter(color: states[currentTierIdx].color),
          //   ),
          // ),
          // Progress bar and circles
          Positioned(
            top: 18,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(states.length, (index) {
                final state = states[index];
                final isActive =
                    currentPoints >= state.min && currentPoints <= state.max;
                final isCompleted = currentPoints > state.max;

                return Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: (isActive || isCompleted)
                            ? state.color.withOpacity(0.15)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isCompleted
                              ? state.color
                              : (isActive ? state.color : Colors.grey.shade300),
                          width: 2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: PackageAssets.image(
                          state.iconAsset,
                          color: (isActive || isCompleted)
                              ? null
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                    if (index < states.length - 1)
                      Stack(
                        children: [
                          // Background bar
                          Container(
                            width: 50,
                            height: 4,
                            color: Colors.grey.shade300,
                          ),
                          // Foreground progress bar
                          if (currentPoints > state.min)
                            Container(
                              width: _getBarFillWidth(
                                currentPoints,
                                state,
                                states[index + 1],
                              ),
                              height: 4,
                              color: state.color,
                            ),
                        ],
                      ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _TierState {
  final String name;
  final String iconAsset;
  final int min;
  final int max;
  final Color color;

  _TierState(this.name, this.iconAsset, this.min, this.max, this.color);
}

// Info card
class _TierInfoCard extends StatelessWidget {
  final String tierLabel;
  final int tierPoints;
  final int userPoints;
  final List<String> benefits;

  const _TierInfoCard({
    required this.tierLabel,
    required this.tierPoints,
    required this.userPoints,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    String leftLabel;
    int leftValue;

    if (tierLabel == "BRONZE") {
      leftLabel = "Complete";
      leftValue = 0;
    } else {
      leftLabel = "Current Tier";
      leftValue = tierPoints;
    }

    // Choose triangle color based on tier
    Color triangleColor;
    switch (tierLabel) {
      case "BRONZE":
        triangleColor = const Color(0xFFFFFFFF);
        break;
      case "SILVER":
        triangleColor = const Color(0xFFFFFFFF);
        break;
      case "GOLD":
        triangleColor = const Color(0xFFFFFFFF);
        break;
      case "DIAMOND":
        triangleColor = const Color(0xFFFFFFFF);
        break;
      default:
        triangleColor = Colors.grey;
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Triangle pointer on top border
        Positioned(
          top: 0,
          child: CustomPaint(
            size: const Size(32, 18),
            painter: _TrianglePainter(color: triangleColor),
          ),
        ),
        // Card container
        Container(
          margin: const EdgeInsets.only(top: 14, left: 18, right: 18),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
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
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          leftLabel,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "$leftValue points",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 38, color: Colors.grey[300]),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Total",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "$userPoints points",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Benefits list
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: benefits
                    .map(
                      (b) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
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
                                  fontSize: 15,
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
            ],
          ),
        ),
      ],
    );
  }
}
// ...existing code...

double _getBarFillWidth(int points, _TierState start, _TierState end) {
  if (points <= start.max) return 0;
  if (points >= end.min) return 50;
  // Partial fill between start.max and end.min
  double segmentPoints = (end.min - start.max).toDouble();
  double userProgress = (points - start.max).toDouble();
  return (userProgress / segmentPoints * 50).clamp(0.0, 50.0);
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter({this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawShadow(path, Colors.black.withOpacity(0.1), 3, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Description card
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
          // Title
          Text(
            "How Do I Get Carbon Credit Points?",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),

          // Description
          Text(
            "You earn Carbon Credit Points every time you choose a greener journey with Thai Smile Bus. These points reflect the amount of CO₂ you help save by traveling sustainably.",
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.4,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          // Subtitle
          Text(
            "Ways to Earn",
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),

          // Bullet list
          _buildBullet(
            "Ride an EV Bus – Every trip you take helps reduce emissions and earns you points.",
          ),
          _buildBullet(
            "Support the Upcycle Program – Purchase or wear Thai Smile Upcycle products made from recycled materials to collect bonus points.",
          ),
          _buildBullet(
            "Refer a Friend – Invite your friends to ride Thai Smile Bus and earn extra points when they join the movement.",
          ),
          _buildBullet(
            "Complete Monthly Challenges – Participate in eco-missions and unlock bonus points.",
          ),
          _buildBullet(
            "Special Promotions – Watch out for seasonal events with limited-time point multipliers.",
          ),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16, height: 1.4)),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
