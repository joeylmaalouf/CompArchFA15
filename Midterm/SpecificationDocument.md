# Specification Document


### Inputs and Outputs

| Device | Type   |
|--------|--------|
| Button | Input  |
| LED    | Output |


### Operational Modes

Light power level over time:

##### Off
![Off](images/off.png)

##### On
![On](images/on.png)

##### Blinking

![Blinking](images/blinking.png)

##### Dim
![Dim](images/dim.png)


### Measurements

When the mode is set to blinking, the light will cycle once per second, giving us a blink rate of 1Hz.


### Finite State Machine

The light has 4 possible patterns, each with a unique set of flags for the light level, so we create a state for each one. The flow is very simple; with each new button press, we cycle through to the next state.

![FSM](images/fsm.png)

| # | State | Light Power Level | Next State | Sel0 | Sel1 |
|---|-------|-------------------|------------|------|------|
| 0 | Off   | 0                 | On         | 0    | 0    |
| 1 | On    | 1                 | Blink      | 0    | 1    |
| 2 | Blink | 1, 0, 1, 0, ...   | Dim        | 1    | 0    |
| 3 | Dim   | 0.5               | Off        | 1    | 1    |
