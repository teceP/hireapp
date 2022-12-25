import 'package:auto_route/auto_route.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: const Text('Benachrichtigungen'),
        actions: [
          _buildPopupMenuButton(),
        ],
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: _buildOptions(context),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: _buildTilesList(context),
          )
        ],
      ),
    );
  }

  Widget _buildPopupMenuButton() => PopupMenuButton<int>(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        offset: Offset(
            0, AppBar().preferredSize.height + AppFinals.verticalPadding),
        //color: Colors.grey,
        elevation: AppFinals.elevation,
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Row(
              children: const [
                Icon(
                  Icons.star,
                  color: Colors.black,
                ),
                SizedBox(
                  // sized box with width 10
                  width: 10,
                ),
                Text("Get The App")
              ],
            ),
          ),
          PopupMenuItem(
            value: 2,
            // row has two child icon and text
            child: Row(
              children: const [
                Icon(
                  Icons.chrome_reader_mode,
                  color: Colors.black,
                ),
                SizedBox(
                  // sized box with width 10
                  width: 10,
                ),
                Text("About")
              ],
            ),
          ),
        ],
      );

  Widget _buildOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppFinals.verticalPaddingAdditional,
        left: AppFinals.horizontalPaddingLess,
        right: AppFinals.horizontalPaddingLess,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /*ChoiceChip(
            label: Text('asd'),
            selected: _nurOffen,
          ),*/
          TextButton(
            onPressed: () {},
            child: const Text('Erinnerungen'),
          ),
          const SizedBox(
            width: AppFinals.horizontalPaddingLess,
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Bevorstehend'),
          ),
          const SizedBox(
            width: AppFinals.horizontalPaddingLess,
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Abgeschlossen'),
          ),
        ],
      ),
    );
  }

  Widget _buildTilesList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: false,
      itemCount: 50,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        indent: AppFinals.horizontalPadding,
        endIndent: AppFinals.horizontalPadding,
      ),
      itemBuilder: (context, chatId) => _buildTile(context, chatId),
    );
  }

  Widget _buildTile(BuildContext context, int index) {
    return ListTile(
      onTap: () {
        context.router.push(SingleChatRoute(chatId: index));
      },
      contentPadding: const EdgeInsets.symmetric(
          horizontal: AppFinals.horizontalPadding,
          vertical: AppFinals.verticalPaddingAdditional),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(AppFinals.borderRadius),
        child: SizedBox(
          height: 70,
          width: 70,
          child: Image.asset('assets/dummy/tabbar/animals/welpe.jpg',
              fit: BoxFit.cover),
        ),
      ),
      title: Text('Chat ID - $index'),
    );
  }
}
