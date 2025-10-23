import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tsb_mini/package_mode.dart';
import 'package:tsb_mini/theme/color_theme.dart';

class TransferListViewFrame extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Function(Map<String, dynamic> item)? onTapItem;

  const TransferListViewFrame({
    super.key,
    required this.items,
    this.shrinkWrap = false,
    this.physics,
    this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 90),
          child: Column(
            children: [
              PackageAssets.image(
                "assets/image/NoDataFound.png",
                width: 182,
                height: 169,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemBuilder: (context, index) {
        final item = items[index];
        return _TapCard(
          onTap: () {
            if (onTapItem != null) onTapItem!(item);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color.fromRGBO(231, 230, 230, 1),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  if (onTapItem != null) onTapItem!(item);
                },
                child: ListTile(
                  leading: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0XFF083f8c),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: item['icon'] as Widget),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      item['from_name'],
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        height: 1.5,
                        color: AppColors.textdarkblack,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    item['id'],
                    style: GoogleFonts.inter(
                      fontSize: 12.5,
                      color: AppColors.textLightFrosted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          item['date'],
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: item['status'] == 'increase' ? '+' : '-',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: item['status'] == 'increase'
                                    ? AppColors.textgreen
                                    : AppColors.textRed,
                              ),
                            ),
                            TextSpan(
                              text: item['point'].toString(),
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: item['status'] == 'increase'
                                    ? AppColors.textgreen
                                    : AppColors.textRed,
                              ),
                            ),
                            TextSpan(
                              text: ' CC',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: item['status'] == 'increase'
                                    ? AppColors.textgreen
                                    : AppColors.textRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Custom tap card with scale animation
class _TapCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _TapCard({required this.child, this.onTap});

  @override
  State<_TapCard> createState() => _TapCardState();
}

class _TapCardState extends State<_TapCard>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.97); // shrink slightly
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
