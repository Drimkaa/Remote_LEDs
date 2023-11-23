/*Container(
height: 50,
child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
CustomIconButton(
iconData: Icons.arrow_back_rounded,
iconSize: 24,
onPressed: () {
model.isEdit = !model.isEdit;

changeIsEdit();
},
),
Text(
"Выбрано (${model.deleteCount})",
textScaleFactor: 1.5,
),
CustomIconButton(
iconData: Icons.select_all,
iconSize: 24,
onPressed: () {
model.selectToDeleteAll();
},
),
])),
if (startEditAnimation)
Positioned(
right: 16,
bottom: 66,
height: 82,
child: SingleChildScrollView(
physics: const NeverScrollableScrollPhysics(),
child: AnimatedContainer(
duration: Duration(milliseconds: 120),
margin: EdgeInsets.only(left: 0, right: 0, top: endEditAnimation ? 0 : 82),
width: 64,
height: 82,
child: Column(children: [
CustomColorIconButton(
onPressed: () {
//Provider.of<LEDModeListPage>(context,listen: false).deleteSelected();
model.deleteSelected();
model.isEdit = !model.isEdit;

changeIsEdit();
},
iconData: Icons.delete_outline_rounded,
background: Colors.redAccent,
iconSize: 64,
radius: 32,
borderSize: 1,
),
]),
),
),
)
*/
