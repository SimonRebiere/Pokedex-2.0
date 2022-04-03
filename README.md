# Pokedex-2.0

This project is a simple list of all pokemons made to show my mastery of the Clean Architecture design pattern.
It's scope is very limited since my time also is.
It's called "2.0" because my first iOS was also a pokedex 6 years ago when I was still a student in Epitech programming school.

For a project of such a small scale Clean Architecture is actually a poor choice, but I wanted to show how I implement that design pattern. MVC or MVVM would have been a better choice on such a project.
As Swift is a protocol orientated programming langage I added protocols everywhere it was needed, to ensure loose coupling of the objects.
Using protocol also allowed me to create Unit Test by injecting a Mock or Fake class for every dependencies. This ensures full control over the data flow in the actual app.
For readability of the code I wrote comments, on important function, in a way that explain the reasoning behind my implementation rather than a technical explanation of the function, which I find more understandable as a developer.
For ease of use and image caching I used a great external lib named Kingfisher.

If I can get more time in the future I'll probably add a detailled view for each pokemon to shows more complex UI implementation and UX skills. For the moment this first version already show some of my skills which is the primary goal.

Thanks to Andrew Tyler for the pixaleted font, you can find more of his work on www.AndrewTyler.net and contact him font@andrewtyler.net
