% CHARACTER DATABASE

% character (name, gender, age_group, hair_color, image_url)
character("Homer Simpson", "male", "adult", "black", "http://pngimg.com/uploads/simpsons/simpsons_PNG15.png").
character("Bart Simpson", "male", "kid", "yellow", "https://dumielauxepices.net/sites/default/files/gas-mask-clipart-bart-simpson-617813-6222676.png").
character("Marge Simpson", "female", "adult", "blue", "https://img.sharetv.com/shows/characters/thumbnails/the_simpsons.marge_simpson.jpg").
character("Lisa Simpson", "female", "kid", "yellow", "https://d14209uukh82fi.cloudfront.net/images/users/48190/small/247_tablet_lisa_inline2_v1.png?1451335881").
character("Maggie Simpson", "female", "kid", "yellow", "https://img.sharetv.com/shows/characters/thumbnails/the_simpsons.others.jpg").
character("Apu Nahasapeemapetilon", "male", "adult", "black", "https://1843784937.rsc.cdn77.org/wp-content/uploads/2018/10/apu-200x200.jpg").
character("Montgomery Burns", "male", "old","white", "https://images.forbes.com/media/lists/fictional/2005/05.jpg").
character("Milhouse Van Houten", "male", "kid", "blue", "https://fastly.4sqi.net/img/general/200x200/19548309_ge9LCKliykbrlupf9QQI2gtb_W_ltsBoyt1Z-p7MZu0.jpg").
character("Ned Flanders", "male", "adult","brown", "http://images5.fanpop.com/image/photos/28600000/Ned-Flanders-ned-flanders-28650655-200-200.jpg").
character("Moe Szyslak", "male", "old","gray", "http://www.quoteswarehouse.com/img/famous/moe-szyslak.jpg").
character("Krusty Clown", "male", "adult","green", "https://img.sharetv.com/shows/characters/thumbnails/the_simpsons.krusty_the_klown.jpg").
character("Nelson Muntz", "male", "kid","brown", "https://img.sharetv.com/shows/characters/thumbnails/the_simpsons.nelson_muntz.jpg").
character("Waylon Smithers", "male", "adult", "brown", "https://img.sharetv.com/shows/characters/thumbnails/the_simpsons.waylon_smithers.jpg").
character("Edna Krabappel", "female", "adult","brown", "https://pbs.twimg.com/profile_images/644654173263384576/S3LLIVYr_200x200.jpg").
character("Seymour Skinner", "male", "adult","gray", "https://pbs.twimg.com/profile_images/724673219232456705/Garjwk_5_400x400.jpg").
character("Barney Gumble", "male", "adult","brown", "https://api.mbtidatabase.com/profile_images/28671.png").
character("Ralph Wiggum", "male", "kid","brown", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRNxpi1L1WE7zw4fmPPpU-N8jonDDI2TXQBZDAkR1mmmjAj-aYlA").
character("Fat Tony", "male", "adult","gray", "http://fanaru.com/the-simpsons/image/135386-the-simpsons-fat-tony.jpg").
character("Abraham Simpson", "male", "old","yellow", "http://3.bp.blogspot.com/_fUzorZk31Ss/Sh_WhLlRQAI/AAAAAAAACrY/lLVAAfjqH5c/s200/abraham_simpson.png").
character("Clancy Wiggum", "male", "adult","blue", "https://steamuserimages-a.akamaihd.net/ugc/856101343596355101/F6CBA32D5600A95C421C5734DFFCB931FDD0F46D/?imw=200&imh=200&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true").
character("Willie", "male", "adult","red", "https://static.classora.com/files/uploads/images/entries/671654/main.jpg").
character("Julius Hibber", "male", "adult","black", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_OA1JADXHtab-0dmDfWvDpX-5QT3wAcXQzNTVPdP7Xp7wbPvw").
character("Joe Quimby", "male", "adult","brown", "https://pbs.twimg.com/profile_images/1081768063819628544/VvuuC6HH_200x200.jpg").
character("Kent Brockman", "male", "old", "white", "https://pbs.twimg.com/profile_images/1054039722815905792/_EA35DdI_200x200.jpg").
character("Reverendo Lovejoy", "male", "adult","black", "http://www.quoteswarehouse.com/img/famous/reverend-lovejoy.jpg").

% REST API

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).

% URL handlers.
:- http_handler('/', handle_request, []).


% NO FILTERS
solve(_{}, _{answer:Result}) :-
    findall([Name,URL], character(Name, _, _ , _, URL), Result).

% GENDER FILTER
solve(_{gender:Gender}, _{answer:Result}) :-
    findall([Name,URL], character(Name, Gender, _ , _,URL), Result).

% AGE FILTER
solve(_{age:Age}, _{answer:Result}) :-
    findall([Name,URL], character(Name, _, Age , _,URL), Result).

% HAIR FILTER
solve(_{hair:Hair}, _{answer:Result}) :-
    findall([Name,URL], character(Name, _, _ , Hair,URL), Result).


% GENDER & AGE FILTER
solve(_{gender:Gender, age:Age}, _{answer:Result}) :-
    findall([Name,URL], character(Name, Gender, Age , _,URL), Result).


% GENDER & HAIR FILTER
solve(_{gender:Gender, hair:Hair}, _{answer:Result}) :-
    findall([Name,URL], character(Name, Gender,_ , Hair,URL), Result).


% AGE & HAIR FILTER
solve(_{age:Age, hair:Hair}, _{answer:Result}) :-
    findall([Name,URL], character(Name, _ , Age , Hair,URL), Result).

% ALL FILTER
solve(_{gender:Gender, age:Age, hair:Hair}, _{answer:Result}) :-
    findall([Name,URL], character(Name, Gender, Age , Hair,URL), Result).
    
handle_request(Request) :-
    http_read_json_dict(Request, Query),
    solve(Query, Solution),
    reply_json_dict(Solution).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).

:- initialization(server(8000)).