    extensions[py]

    breed [f1s f1]
    breed [f2s f2]
    breed [f3s f3]
    breed [f4s f4]
    breed [f5s f5]
    breed [f6s f6]
    breed [f7s f7]

    ;f1s-own [cur-growth1]
    ;f2s-own [cur-growth2]
    ;f3s-own [cur-growth3]
    ;f4s-own [cur-growth4]
    ;f5s-own [cur-growth5]
    ;f6s-own [cur-growth6]
    ;f7s-own [cur-growth7]

    patches-own [matter-decomp decomp? wait-time time-waited]

    turtles-own [rank]

    globals [cur-temp cur-moist
    f1color f2color f3color f4color f5color f6color f7color brown-hi brown-lo

    decomp-rate1  cur-growth1 cur-growth-rate1 new-growth1 amount-decomp1 temp-at-maxr1 moist-at-maxr1 rank1 max-rate1
    decomp-rate2  cur-growth2 cur-growth-rate2 new-growth2 amount-decomp2 temp-at-maxr2 moist-at-maxr2 rank2 max-rate2
    decomp-rate3  cur-growth3 cur-growth-rate3 new-growth3 amount-decomp3 temp-at-maxr3 moist-at-maxr3 rank3 max-rate3
    decomp-rate4  cur-growth4 cur-growth-rate4 new-growth4 amount-decomp4 temp-at-maxr4 moist-at-maxr4 rank4 max-rate4
    decomp-rate5  cur-growth5 cur-growth-rate5 new-growth5 amount-decomp5 temp-at-maxr5 moist-at-maxr5 rank5 max-rate5
    decomp-rate6  cur-growth6 cur-growth-rate6 new-growth6 amount-decomp6 temp-at-maxr6 moist-at-maxr6 rank6 max-rate6
    decomp-rate7  cur-growth7 cur-growth-rate7 new-growth7 amount-decomp7 temp-at-maxr7 moist-at-maxr7 rank7 max-rate7
    ]


    to setup
    clear-all
    set brown-hi 1 set brown-lo 0
    ask patches [
        ; patches are ground litter or not
        ifelse random 100 < ground-litter-percent
        [set matter-decomp 0.80 set decomp? true
            set pcolor scale-color brown matter-decomp brown-hi brown-lo]
        [set decomp? false set matter-decomp 0.20 set pcolor green]

        set wait-time 0
        set time-waited 0
    ]

    set-default-shape turtles "fungi"

    initialize-vars

    sprout-fungi




    reset-ticks
    end

    to go
    calculate-growth-rate

    grow-fungi
    fight-fungi
    death-fungi
    decompose
    add-litter



    tick
    ;my-update-plots
    end

    to initialize-vars
    set cur-temp 22
    set cur-moist -0.5

    set cur-growth1 0
    set cur-growth2 0
    set cur-growth3 0
    set cur-growth4 0
    set cur-growth5 0
    set cur-growth6 0
    set cur-growth7 0

    calculate-growth-rate
    ;set cur-growth-rate1 1
    ;set cur-growth-rate2 5
    ;set cur-growth-rate3 10
    ;set cur-growth-rate4 15
    ;set cur-growth-rate5 20
    ;set cur-growth-rate6 25
    ;set cur-growth-rate7 30

    set new-growth1 0
    set new-growth2 0
    set new-growth3 0
    set new-growth4 0
    set new-growth5 0
    set new-growth6 0
    set decomp-rate1 0.0180
    set decomp-rate2 0.0474
    set decomp-rate3 0.0153
    set decomp-rate4 0.00878
    set decomp-rate5 0.0987
    set decomp-rate6 0.0598
    set decomp-rate7 0.0345

    set temp-at-maxr1 23.81
    set temp-at-maxr2 28.54
    set temp-at-maxr3 29.23
    set temp-at-maxr4 26.94
    set temp-at-maxr5 30.4
    set temp-at-maxr6 27.3
    set temp-at-maxr7 33.42

    set moist-at-maxr1 -.76
    set moist-at-maxr2 -.428
    set moist-at-maxr3 -.597
    set moist-at-maxr4 -.537
    set moist-at-maxr5 -.26
    set moist-at-maxr6 -.24
    set moist-at-maxr7 -.425

    set rank1 0.374
    set rank2 0.878
    set rank3 0.516
    set rank4 0.278
    set rank5 0.788
    set rank6 0.284
    set rank7 0.634

    set max-rate1 .768
    set max-rate2 11.89
    set max-rate3 7.08
    set max-rate4 1.31
    set max-rate5 12.16
    set max-rate6 7.55
    set max-rate7 10.65

    set f1color red
    set f2color orange
    set f3color yellow
    set f4color cyan
    set f5color blue
    set f6color violet
    set f7color magenta

    end

    to sprout-fungi
    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f1s 1 [set color red set rank rank1]]

    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f2s 1 [set color orange set rank rank2]]

    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f3s 1 [set color yellow set rank rank3]]

    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f4s 1 [set color cyan set rank rank4]]

    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f5s 1 [set color blue set rank rank5]]

    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f6s 1 [set color violet set rank rank6]]

    ask n-of initial-fungi-per-cluster patches with [decomp? and not any? other turtles-here]
    [sprout-f7s 1 [set color magenta set rank rank7]]

    end

    to calculate-growth-rate
      ifelse cur-temp <= temp-at-maxr1
        [set cur-growth-rate1 3 * (.0224 * cur-temp - .24)]
        [set cur-growth-rate1 3 * (-.0568 * cur-temp + 2.12)]

        ifelse cur-moist <= moist-at-maxr1
        [set cur-growth-rate1 cur-growth-rate1 * (-.443 * cur-moist + .66)]
        [set cur-growth-rate1 cur-growth-rate1 * (.12 * cur-moist + 1.09)]

        ifelse cur-temp <= temp-at-maxr2
        [set cur-growth-rate2 3 * (.451 * cur-temp - .93)*(-.637 * cur-moist + .66)]
        [set cur-growth-rate2 3 * (-1.44 * cur-temp + 52.85)*(.169 * cur-moist + 1.09)]

        ifelse cur-moist <= moist-at-maxr2
        [set cur-growth-rate2 cur-growth-rate2 * (-.796 * cur-moist + .66)]
        [set cur-growth-rate2 cur-growth-rate2 * (.23 * cur-moist + 1.1)]

        ifelse cur-temp <= temp-at-maxr3
        [set cur-growth-rate3 3 * (0.33 * cur-temp - 2.57)*(-.524 * cur-moist + .68)]
        [set cur-growth-rate3 3 * (-1.21 * cur-temp + 42.4)*(.172 * cur-moist + 1.1)]

        ifelse cur-moist <= moist-at-maxr3
        [set cur-growth-rate3 cur-growth-rate3 * (-.541 * cur-moist + .68)]
        [set cur-growth-rate3 cur-growth-rate3 * (.197 * cur-moist + 1.12)]

        ifelse cur-temp <= temp-at-maxr4
        [set cur-growth-rate4 3 * (0.0616 * cur-temp - .34)*(-.620 * cur-moist + .67)]
        [set cur-growth-rate4 3 * (-.152 * cur-temp + 5.42)*(.231 * cur-moist + 1.12)]

        ifelse cur-moist <= moist-at-maxr4
        [set cur-growth-rate4 cur-growth-rate4 * (-.637 * cur-moist + .66)]
        [set cur-growth-rate4 cur-growth-rate4 * (.169 * cur-moist + 1.09)]

        ifelse cur-temp <= temp-at-maxr5
        [set cur-growth-rate5 3 * (0.438 * cur-temp - 1.11)*(-1.32 * cur-moist + .66)]
        [set cur-growth-rate5 3 * (-1.60 * cur-temp + 60.81)*(.318 * cur-moist + 1.08)]

        ifelse cur-moist <= moist-at-maxr5
        [set cur-growth-rate5 cur-growth-rate5 * (-1.32 * cur-moist + .66)]
        [set cur-growth-rate5 cur-growth-rate5 * (.318 * cur-moist + 1.08)]

        ifelse cur-temp <= temp-at-maxr6
        [set cur-growth-rate6 3 * (.423 * cur-temp - 4.62)*(-.443 * cur-moist + .66)]
        [set cur-growth-rate6 3 * (-1.35 * cur-temp + 44.35)*(.12 * cur-moist + 1.09)]

        ifelse cur-moist <= moist-at-maxr6
        [set cur-growth-rate6 cur-growth-rate6 * (-1.47 * cur-moist + .65)]
        [set cur-growth-rate6 cur-growth-rate6 * (.327 * cur-moist + 1.08)]

        ifelse cur-temp <= temp-at-maxr7
        [set cur-growth-rate7 3 * (.405 * cur-temp - 3.07)*(-.97 * cur-moist + .66)]
        [set cur-growth-rate7 3 * (-1.27 * cur-temp + 53.01)*(.281 * cur-moist + 1.1)]

        ifelse cur-moist <= moist-at-maxr7
        [set cur-growth-rate7 cur-growth-rate7 * (-.772 * cur-moist + .67)]
        [set cur-growth-rate7 cur-growth-rate7 * (.24 * cur-moist + 1.1)]
    end

    to grow-fungi


    to fight-fungi
        ask turtles [; with [any? other turtles-here] [;[any? f1s-here] [
            let fight1 self
            let fight1-rank rank
            ask turtles-on (patch-set patch-here neighbors)[ ;(turtle-set self turtles-on neighbors)

                if breed != [ breed ] of fight1
                [
                 let fight2 self
                 let fight2-rank rank
                 let rank-diff fight1-rank - fight2-rank
                 if rank-diff > 0.7 and rank-diff <= 1 [die
                 ;ask patch-here[
                 ;sprout-[breed] of fight1 1 [set color f1color]
                 ];]
                 if rank-diff > 0.4 and rank-diff <= 0.7 [
                 if (random 100) <= 50 [
                   die
                 ]
                 ] ;50
                 if rank-diff > 0.1 and rank-diff <= 0.4 [
                 if (random 100) < 33 [
                   die
                 ]
                 ] ;50] ;33
                ]
            ]

            ;ask neighbors with [any? other turtles-here with [ breed != [ breed ] of fight1]] [
            ;    let fight2 one-of turtles-here
            ;    let fight2-rank rank
            ;    let rank-diff fight1-rank - fight2-rank
            ;    ;if neg do nothing- so each set of turtles fight once
            ;   if rank-diff > 0.7 and rank-diff <= 1 [die]
            ;    if rank-diff > 0.4 and rank-diff <= 0.7 [die]
            ;    if rank-diff > 0.1 and rank-diff <= 0.4[]
            ;    ;0.1 < rank-diff <= 0.1 [set wait-time 2] do nothing, standstill
            ;]


        ]
        ;set time-waited time-waited + 1
        ;ask patches [
        ;if time-waited >= wait-time
        ;[]
        ;]

    end

    to add-litter ;only add litter during fall

    end

    to death-fungi ;die if growth rate < 25% of max
      ask f1s [if cur-growth-rate1 < 0.25 * max-rate1 [die]]
        ask f2s [if cur-growth-rate2 < 0.25 * max-rate2 [die]]
        ask f3s [if cur-growth-rate3 < 0.25 * max-rate3 [die]]
        ask f4s [if cur-growth-rate4 < 0.25 * max-rate4 [die]]
        ask f5s [if cur-growth-rate5 < 0.25 * max-rate5 [die]]
        ask f6s [if cur-growth-rate6 < 0.25 * max-rate6 [die]]
        ask f7s [if cur-growth-rate7 < 0.25 * max-rate7 [die]]
    end


    to decompose ;green
    ;cont scaling of brown color? scale-color

    ;f1
    ask patches with [any? f1s-here] [
        let new-decomp matter-decomp * decomp-rate1
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp1 amount-decomp1 + new-decomp
    ]

    ;f2
    ask patches with [any? f2s-here] [
        let new-decomp matter-decomp * decomp-rate2
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp2 amount-decomp2 + new-decomp
    ]

    ;f3
    ask patches with [any? f3s-here] [
        let new-decomp matter-decomp * decomp-rate3
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp3 amount-decomp3 + new-decomp
    ]

    ;f4
    ask patches with [any? f4s-here] [
        let new-decomp matter-decomp * decomp-rate4
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp4 amount-decomp4 + new-decomp
    ]

    ;f5
    ask patches with [any? f5s-here] [
        let new-decomp matter-decomp * decomp-rate5
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp5 amount-decomp5 + new-decomp
    ]

    ;f6
    ask patches with [any? f6s-here] [
        let new-decomp matter-decomp * decomp-rate6
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp6 amount-decomp6 + new-decomp
    ]

    ;f7
    ask patches with [any? f7s-here] [
        let new-decomp matter-decomp * decomp-rate7
        set matter-decomp matter-decomp - new-decomp
        set amount-decomp7 amount-decomp7 + new-decomp
    ]

    ask patches with [any? turtles-here] [
        ;update color
        ifelse matter-decomp >= .3
        [set pcolor scale-color brown matter-decomp brown-hi brown-lo]
        [set pcolor green set decomp? false
        ask turtles-here [die]]
    ]

    end

;update the plots ONLY USE FOR SPECIAL COUNTS
;to my-update-plots
  ;set-current-plot-pen "f1s"
  ;plot count f1s

  ;set-current-plot-pen "f2s"
  ;plot count f2s

  ;set-current-plot-pen "wolves"
  ;plot count wolves * 10 ;; scaling factor so plot looks nice

  ;set-current-plot-pen "grass"
  ;plot sum [ grass-amount ] of patches / 50 ;; scaling factor so plot looks nice

;end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
1028
829
-1
-1
10.0
1
14
1
1
1
0
1
1
1
-40
40
-40
40
1
1
1
ticks
30.0

BUTTON
32
50
95
83
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
116
51
179
84
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
19
109
191
142
ground-litter-percent
ground-litter-percent
0
100
80.0
1
1
NIL
HORIZONTAL

SLIDER
20
162
194
195
initial-fungi-per-cluster
initial-fungi-per-cluster
0
100
80.0
1
1
NIL
HORIZONTAL

PLOT
21
221
221
371
Population of Fungi Clusters over Time
Time
Population
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"f1s" 1.0 0 -2674135 true "" "plot count f1s"
"f2s" 1.0 0 -955883 true "" "plot count f2s"
"f3s" 1.0 0 -1184463 true "" "plot count f3s"
"f4s" 1.0 0 -11221820 true "" "plot count f4s"
"f5s" 1.0 0 -13345367 true "" "plot count f5s"
"f6s" 1.0 0 -8630108 true "" "plot count f6s"
"f7s" 1.0 0 -5825686 true "" "plot count f7s"

PLOT
21
412
221
562
Decomposition by Fungi Clusters over Time
Time
Decomposition (patches)
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"f1s-decomp" 1.0 0 -2674135 true "" "plot amount-decomp1"
"f2s-decomp" 1.0 0 -955883 true "" "plot amount-decomp2"
"f3s-decomp" 1.0 0 -1184463 true "" "plot amount-decomp3"
"f4s-decomp" 1.0 0 -11221820 true "" "plot amount-decomp4"
"f5s-decomp" 1.0 0 -14070903 true "" "plot amount-decomp5"
"f6s-decomp" 1.0 0 -8630108 true "" "plot amount-decomp6"
"f7s-decomp" 1.0 0 -5825686 true "" "plot amount-decomp7"

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

fungi
true
0
Polygon -7500403 true true 30 180 270 180 270 120 225 75 195 60 105 60 75 75 30 120 30 180
Polygon -7500403 true true 105 285 195 285 195 180 105 180 105 285

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
