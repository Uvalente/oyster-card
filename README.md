# Oyster Card

Create a Oyster card and stations application.
Saves your journey history and deduct a fare for your travel.
The more zone you cross, the more you get charged.
If a touch in or touch out is skipped, a penalty fare is charged.

## Getting started

1. Fork this repo, and clone to your local machine
2. Run the command `gem install bundle` (if you don't have bundle already)
3. When the installation completes, run `bundle`

## Usage

Open in IRB and create an instance of Oystercard.

Create as many as you want of Station instances.

Calling on the card the top up method, will update the balance of the desired amount.

The in_journey? method will let you know if any not completed journey is present.

To start a journey, use the touch_in method, it will save your entry station and let you in, or raise an error if your balance is not enough.

Additionally, if you skipped a previous touch_out, it will charge you a penalty.

To finish the journey, use the touch_out method, it will complete your travel, save the journey in your journeys history and deduct the right amount from your balance.


## Available commands

Classes:

* `Oystercard.new`
* `Station.new(name, zone)`

Methods on Oystercard class:

`card = Oystercard.new`

* `card.top_up(amount)`
* `card.touch_in(station)`
* `card.touch_out(station)`
* `card.balance`
* `card.in_journey?`