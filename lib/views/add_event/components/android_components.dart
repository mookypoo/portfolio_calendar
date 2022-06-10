import 'package:flutter/material.dart';
import 'package:portfolio_calendar/views/add_event/components/common_components.dart' show ColorCircle, UserColorRow;

import '../../../class/user_color.dart';
import '../../../provider/add_event_provider.dart';
import '../../../repos/variables.dart';

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
              Text("Your Colors", style: Theme.of(context).textTheme.bodyText1,),
              this.addEventProvider.addEventMode != AddEventMode.deleteColor ? GestureDetector(
                onTap: this.addEventProvider.addColorMode,
                child: Text("Add", style: Theme.of(context).textTheme.bodyText1,),
              ) : Container(),
              GestureDetector(
                onTap: this.addEventProvider.deleteMode,
                child: Text(this.addEventProvider.addEventMode == AddEventMode.deleteColor ? "Cancel" : "Delete", style: Theme.of(context).textTheme.bodyText1,),
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
              icon: Icons.remove,
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
      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
      height: 130.0,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  autofocus: true,
                  onChanged: this.addEventProvider.onChangedNewTitle,
                  cursorColor: MyColors.primary,
                  decoration: InputDecoration(
                    hintText: "Title",
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyColors.primary)),
                    contentPadding: const EdgeInsets.only(bottom: 8.0, top: 10.0),
                    isDense: true,
                  ),
                ),
              ),
              ColorCircle(color: this.addEventProvider.newColor),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text("Available Colors", style: Theme.of(context).textTheme.bodyText1),
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
      child: Text("Add notification",style: Theme.of(context).textTheme.bodyText1, ),
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
      height: 50.0,
      width: MediaQuery.of(context).size.width/2,
      child: TextButton(
        style: ButtonStyle(overlayColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.1))),
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
            child: TextField(
              controller: this.textCt,
              cursorColor: MyColors.primary,
              style: TextStyle(fontSize: 23.0),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
                contentPadding: const EdgeInsets.only(left: 20.0, top: 15.0, bottom: 10.0),
              ),
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
                  child: Text(this.addEventProvider.addEventMode == AddEventMode.addNote ? "Cancel / Delete" : "Add notes", style: Theme.of(context).textTheme.bodyText1, ),
                ),
                this.addEventProvider.addEventMode == AddEventMode.addNote ? GestureDetector(
                  onTap: () => this.addEventProvider.saveNote(this.ct.text),
                  child: Text("Save", style: Theme.of(context).textTheme.bodyText1, ),
                ) : Container(),
              ],
            ),
          ),
          this.addEventProvider.addEventMode == AddEventMode.addNote
            ? Container(
              width: 290.0,
              child: TextField(
                autofocus: true,
                controller: this.ct..text = this.addEventProvider.note,
                maxLines: null,
                decoration: InputDecoration(
                  constraints: BoxConstraints(),
                  isDense: true,
                  contentPadding: const EdgeInsets.only(bottom: 7.0, top: 13.0),
                ),
              ),
            ) : Container(),
          this.addEventProvider.addEventMode != AddEventMode.addNote ? Text(this.addEventProvider.note) : Container(),
        ],
      ),
    );
  }
}
