import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_widget/wc_connection_model.dart';

class WCConnectionWidgetInfo extends StatelessWidget {
  const WCConnectionWidgetInfo({
    super.key,
    required this.model,
  });

  final WCConnectionModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(
          StyleConstants.linear16,
        ),
      ),
      padding: const EdgeInsets.all(
        StyleConstants.linear8,
      ),
      margin: const EdgeInsetsDirectional.only(
        top: StyleConstants.linear8,
      ),
      child: model.elements != null ? _buildList() : _buildText(),
    );
  }

  Widget _buildList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (model.title != null)
          Text(
            model.title!,
            style: StyleConstants.layerTextStyle3,
          ),
        if (model.title != null) const SizedBox(height: StyleConstants.linear8),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          direction: Axis.horizontal,
          children: model.elements!.map((e) => _buildElement(e)).toList(),
        ),
      ],
    );
  }

  Widget _buildElement(String text) {
    return ElevatedButton(
      onPressed:
          model.elementActions != null ? model.elementActions![text] : null,
      style: ButtonStyle(
        elevation: model.elementActions != null
            ? WidgetStateProperty.all(4.0)
            : WidgetStateProperty.all(0.0),
        padding: WidgetStateProperty.all(const EdgeInsets.all(0.0)),
        visualDensity: VisualDensity.compact,
        backgroundColor: WidgetStateProperty.all(
          StyleConstants.layerColor4,
        ),
        overlayColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
          (states) {
            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(StyleConstants.linear16),
            );
          },
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(
          StyleConstants.linear8,
        ),
        child: Text(
          text,
          style: StyleConstants.layerTextStyle4,
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      model.text!,
      style: StyleConstants.layerTextStyle3,
    );
  }
}
