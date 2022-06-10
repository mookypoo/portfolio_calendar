import 'package:flutter/cupertino.dart';

import '../../../class/user_color.dart';
import '../../../provider/add_event_provider.dart';
import '../../../repos/variables.dart' show MyColors;
import 'common_components.dart';

const TextStyle _style = TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: MyColors.primary);

class ColorTopRow extends StatelessWidget {
  const ColorTopRow({Key? key, required this.addEventProvider, required this.removeColor}) : super(key: key);
  final AddEventProvider addEventProvider;
  final void Function(UserColor uc) removeColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 290.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Your Colors", style: _style),
              this.addEventProvider.addEventMode != AddEventMode.deleteColor ? GestureDetector(
                onTap: this.addEventProvider.addColorMode,
                child: Text("Add", style: _style),
              ) : Container(),
              GestureDetector(
                onTap: this.addEventProvider.deleteMode,
                child: Text(this.addEventProvider.addEventMode == AddEventMode.deleteColor ? "Cancel" : "Delete", style: _style),
              ),
            ],
          ),
        ),
        Container(
          width: 290.0,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 15.0),
            shrinkWrap: true,
            itemBuilder: (_, int index) => UserColorRow(
              onTapRemove: (UserColor uc) {
                this.removeColor(uc);
                this.addEventProvider.removeColor(uc);
              },
              icon: CupertinoIcons.delete,
              mode: this.addEventProvider.addEventMode,
              userColor: this.addEventProvider.userColors[index],
              onTap: this.addEventProvider.changeColor,
            ),
            itemCount: this.addEventProvider.userColors.length,
            scrollDirection: Axis.vertical,
          ),
        )
      ],
    );
  }
}

class AddColorWidget extends StatelessWidget {
  const AddColorWidget({Key? key, required this.addEventProvider}) : super(key: key);
  final AddEventProvider addEventProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0, top: 8.0),
      height: 130.0,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: CupertinoTextField(
                  autofocus: true,
                  placeholderStyle: TextStyle(color: CupertinoColors.secondaryLabel),
                  decoration: BoxDecoration(color: MyColors.bg,),
                  onChanged: this.addEventProvider.onChangedNewTitle,
                  cursorColor: MyColors.primary,
                  placeholder: "Title",
                ),
              ),
              ColorCircle(color: this.addEventProvider.newColor),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text("Available Colors", style: _style),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, int index) => ColorCircle(
                color: this.addEventProvider.eventColors[index],
                onTap: this.addEventProvider.changeNewColor,
              ),
              itemCount: this.addEventProvider.eventColors.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}

class AddNotification extends StatelessWidget {
  const AddNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text("Add notification",style: _style),
      onTap: () async {
        //wait Navigator.of(context).push(ModalRoute)
      },
    );
  }
}

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key? key, this.onPressed, required this.text, required this.save}) : super(key: key);
  final String text;
  final bool save;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.bg,
        boxShadow: <BoxShadow>[BoxShadow(spreadRadius: 0.6),]
      ),
      height: 60.0,
      width: MediaQuery.of(context).size.width/2,
      child: CupertinoButton(
        child: Text(text, style: TextStyle(fontSize: 18.0, color: MyColors.primary),),
        onPressed: () {
          if (this.onPressed != null) this.onPressed!();
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class TitleTextField extends StatelessWidget {
  const TitleTextField({Key? key, required this.textCt, required this.color}) : super(key: key);
  final TextEditingController textCt;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: CupertinoTextField(
              placeholderStyle: TextStyle(color: CupertinoColors.secondaryLabel),
              decoration: BoxDecoration(color: MyColors.bg,),
              controller: this.textCt,
              cursorColor: MyColors.primary,
              style: TextStyle(fontSize: 21.0),
              placeholder: "Title",
            ),
          ),
          ColorCircle(color: color),
        ],
      ),
    );
  }
}

class AddNotes extends StatelessWidget {
  const AddNotes({Key? key, required this.addEventProvider, required this.ct}) : super(key: key);
  final AddEventProvider addEventProvider;
  final TextEditingController ct;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            width: 290.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () => this.addEventProvider.addNoteMode(cancel: true),
                  child: Text(this.addEventProvider.addEventMode == AddEventMode.addNote ? "Cancel / Delete" : "Add notes", style: _style),
                ),
                this.addEventProvider.addEventMode == AddEventMode.addNote ? GestureDetector(
                  onTap: () => this.addEventProvider.saveNote(this.ct.text),
                  child: Text("Save", style: _style),
                ) : Container(),
              ],
            ),
          ),
          this.addEventProvider.addEventMode == AddEventMode.addNote
            ? Container(
                width: 290.0,
                child: CupertinoTextField(
                  autofocus: true,
                  decoration: BoxDecoration(color: MyColors.bg,),
                  controller: this.ct..text = this.addEventProvider.note,
                  maxLines: null,
            ),
          ) : Container(),
          this.addEventProvider.addEventMode != AddEventMode.addNote ? Text(this.addEventProvider.note) : Container(),
        ],
      ),
    );
  }
}
