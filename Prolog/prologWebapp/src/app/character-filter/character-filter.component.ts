import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-character-filter',
  templateUrl: './character-filter.component.html',
  styleUrls: ['./character-filter.component.css']
})
export class CharacterFilterComponent implements OnInit {

  characters : Array<any>;
  noResults : boolean;

  constructor(private http: HttpClient) { }

  // Get all characters from DB
  ngOnInit() {
    this.noResults = false;
  }

  searchCharacters()
  {
    var gender : any = document.getElementById("gender");
    gender = gender.options[ gender.selectedIndex ].value;
    var age : any = document.getElementById("age");
    age = age.options[ age.selectedIndex ].value;
    var hair : any = document.getElementById("hair");
    hair = hair.options[ hair.selectedIndex ].value;

    let request_body = {}
    request_body["gender"] = gender;
    request_body["age"] = age;
    request_body["hair"] = hair;

    this.http.post("http://localhost:4200/api", request_body).subscribe((response: any)=>{
        this.characters = response["answer"];
        this.noResults = this.characters.length == 0
    });
  }
}
