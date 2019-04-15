class Note {
  int _id;
  String _title;
  String _note;
  String _description;
  String _date;
  bool _pin;

  Note(this._title, this._note, this._date, this._description, this._pin);

  Note.withId(this._id, this._title, this._note, this._date, this._description,this._pin);

  int get id => _id;

  String get title => _title;

  String get note => _note;

  String get description => _description;

  String get date => _date;

  bool get pin => _pin;


  set title(String newTitle) {

      this._title = newTitle;

  }

  set note(String newnote) {

      this._note = newnote;

  }

  set description(String newDescription) {

      this._description = newDescription;

  }
  set date(String newDate) {

    this._date = newDate;
  }

  set pin(bool p) {

    this._pin = p;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['note'] = _note;
    map['description'] = _description;
    map['date'] = _date;
    if (_pin)
    map['pin'] = 'true';
    else
      map['pin'] = 'false';


    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._note = map['note'];
    this._description = map['description'];
    this._date = map['date'];
    if (map['pin'] == 'true')
    this._pin = true;
    else
      this._pin = false;
  }
}
