open Core

let parseElves fileName =
  let content = In_channel.read_all fileName in
  let matchEmptyLine = Str.regexp "\n\n" in
  Str.split matchEmptyLine content

let sumCalories elfInventory =
  let matchNewLine = Str.regexp "\n" in
  Str.split matchNewLine elfInventory
  |> List.map ~f:int_of_string |> List.fold ~init:0 ~f:( + )

let rec sumOfMaxThree' list (max1, max2, max3) =
  match list with
  | [] -> max1 + max2 + max3
  | x :: xs when x >= max1 -> sumOfMaxThree' xs (x, max1, max2)
  | x :: xs when x >= max2 -> sumOfMaxThree' xs (max1, x, max2)
  | x :: xs when x >= max3 -> sumOfMaxThree' xs (max1, max2, x)
  | _ :: xs -> sumOfMaxThree' xs (max1, max2, max3)

let sumOfMaxThree list = sumOfMaxThree' list (0, 0, 0)

(*---------------------------
  -- Challenges
  -----------------------------*)

let result1 fileName =
  let max =
    parseElves fileName |> List.map ~f:sumCalories
    |> List.max_elt ~compare:(fun a b -> Int.compare a b)
  in
  match max with
  | Some number -> number
  | None -> 0

let result2 fileName =
  parseElves fileName |> List.map ~f:sumCalories |> sumOfMaxThree

(*---------------------------
  -- Display
  -----------------------------*)

let result =
  let fileNAme = "./data/day1_input.txt" in
  "Day 1 — Result 1: "
  ^ string_of_int (result1 fileNAme)
  ^ "\n" ^ "Day 1 — Result 2: "
  ^ string_of_int (result2 fileNAme)
