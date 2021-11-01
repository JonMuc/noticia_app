class StackWidetSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Over Image'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Image.network(
                'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  'Show text here',
                  style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 22.0),
                )),
          ],
        ),
      ),
    );
  }
}