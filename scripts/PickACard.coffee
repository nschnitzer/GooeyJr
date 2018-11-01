random = (number) ->
  return Math.floor(Math.random() * 13) + 1

rand = random();

alert("Ace") if rand == 1
alert("Two") if rand == 2
alert("Three") if rand == 3
alert("Four") if rand == 4
alert("Five") if rand == 5
alert("Six") if rand == 6
alert("Seven") if rand == 7
alert("Eight") if rand == 8
alert("Nine") if rand == 9
alert("Ten") if rand == 10
alert("Jack") if rand == 11
alert("Queen") if rand == 12
alert("King") if rand == 13
