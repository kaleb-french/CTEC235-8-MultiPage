# Journal
Write your Journal questions and notes here.

Phase 1-
When Navigator.push() is fired it pushes that page returned onto the stack in memory. when the Docking bay button is pushed it runs Navigator.pop() that removes the current page from the stack returning them to the previous one.

Phase 2-
A ListView.Builder can be better than a basic ListView or Column because the builder builds the list items as needed the others are fixed collections of Widgets. The Navigator.push() is creating a route and the PlanetDetail constructor is receiving the data through a named constructor parameter.

Phase 3-
The round-trip nav flow is made possible by the Async await keyword. Await tells the program that the variable its declared in is being returned as a "future," meaning it will continue to run but this is a place holder for return of the route that its being used in. The returning value is returned via the Navigator.pop() as a parameter and the result varible is then given the value.

Phase 4-
The web style urls used by the context.push allows better and more visible routes with the ability to pass parameters through urls like with html. With routes such as /planet/:id all of the planets can be visited by simply changing the :id thats pushed.
