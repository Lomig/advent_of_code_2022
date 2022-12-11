open Base
open Core

(*-----------------------------------------------------------------------------
  -- Custom Types
  -----------------------------------------------------------------------------*)

type item = {worryLevel: int}

type monkey = {
  items: item list;
  targets: int * int;
  operation: int -> int;
  moduloChecker: int;
  inspections: int;
}

(*-----------------------------------------------------------------------------
  -- Parsing
  -----------------------------------------------------------------------------*)

let itemsOf items =
  let regexp = Tyre.int |> Tyre.compile in
  let worryLevels = Tyre.all regexp items |> Caml.Result.get_ok in
  List.map worryLevels ~f:(fun x -> {worryLevel = x})

let operationOf operation =
  let endOfLine =
    String.chop_prefix operation ~prefix:"  Operation: new = "
    |> Caml.Option.get
  in
  match String.split endOfLine ~on:' ' with
  | "old" :: "*" :: "old" :: _ -> fun x -> x * x
  | "old" :: "*" :: num :: _ -> fun x -> x * int_of_string num
  | "old" :: "+" :: num :: _ -> fun x -> x + int_of_string num
  | _ -> failwith "Invalid Input"

let moduloOf modulo =
  let regexp = Tyre.int |> Tyre.compile in
  Tyre.exec regexp modulo |> Caml.Result.get_ok

let targetsOf t1 t2 =
  let regexp = Tyre.int |> Tyre.compile in
  ( Tyre.exec regexp t1 |> Caml.Result.get_ok,
    Tyre.exec regexp t2 |> Caml.Result.get_ok )

let createMonkey items operation modulo t1 t2 =
  {
    items = itemsOf items;
    operation = operationOf operation;
    moduloChecker = moduloOf modulo;
    targets = targetsOf t1 t2;
    inspections = 0;
  }

let rec parseMonkeys' monkeys lines =
  match lines with
  | [_; items; operation; modulo; t1; t2] ->
    createMonkey items operation modulo t1 t2 :: monkeys
  | _ :: items :: operation :: modulo :: t1 :: t2 :: _ :: tail ->
    let newMonkey = createMonkey items operation modulo t1 t2 in
    parseMonkeys' (newMonkey :: monkeys) tail
  | _ -> monkeys

let parseMonkeys fileName =
  In_channel.read_lines fileName |> parseMonkeys' [] |> List.rev

(*-----------------------------------------------------------------------------
  -- Round
  -----------------------------------------------------------------------------*)

let monkeyThrowItem monkey stressReliever =
  match monkey with
  | {items = []; _} -> failwith "Argument Error"
  | {items = x :: xs; targets = t1, t2; _} ->
    let newWorryLevel = stressReliever (monkey.operation x.worryLevel) in
    let catcherIndex =
      if newWorryLevel % monkey.moduloChecker = 0 then t1 else t2
    in
    ( {
        items = xs;
        targets = monkey.targets;
        operation = monkey.operation;
        moduloChecker = monkey.moduloChecker;
        inspections = monkey.inspections + 1;
      },
      {worryLevel = newWorryLevel},
      catcherIndex )

let rec monkeyCatchItem monkeyList throwerMonkey thrownItem catcherIndex
    throwerIndex updatedMonkeyList currentIndex =
  match monkeyList with
  | [] -> updatedMonkeyList |> List.rev
  | _ :: xs when phys_equal currentIndex throwerIndex ->
    monkeyCatchItem xs throwerMonkey thrownItem catcherIndex throwerIndex
      (throwerMonkey :: updatedMonkeyList)
      (currentIndex + 1)
  | x :: xs when phys_equal currentIndex catcherIndex ->
    let catcherMonkey =
      {
        items = x.items @ [thrownItem];
        targets = x.targets;
        operation = x.operation;
        moduloChecker = x.moduloChecker;
        inspections = x.inspections;
      }
    in
    monkeyCatchItem xs throwerMonkey thrownItem catcherIndex throwerIndex
      (catcherMonkey :: updatedMonkeyList)
      (currentIndex + 1)
  | x :: xs ->
    monkeyCatchItem xs throwerMonkey thrownItem catcherIndex throwerIndex
      (x :: updatedMonkeyList) (currentIndex + 1)

let rec inspect monkeyList monkey throwerIndex stressReliever =
  match monkey with
  | _ when List.is_empty monkey.items -> monkeyList
  | _ ->
    let updatedMonkey, updatedItem, catcherIndex =
      monkeyThrowItem monkey stressReliever
    in
    let updatedMonkeyList =
      monkeyCatchItem monkeyList updatedMonkey updatedItem catcherIndex
        throwerIndex [] 0
    in
    inspect updatedMonkeyList updatedMonkey throwerIndex stressReliever

let rec playRound monkeyList index stressReliever =
  match index with
  | _ when index = List.length monkeyList -> monkeyList
  | _ ->
    playRound
      (inspect monkeyList (List.nth_exn monkeyList index) index stressReliever)
      (index + 1) stressReliever

(*-----------------------------------------------------------------------------
  -- Game
  -----------------------------------------------------------------------------*)

let countInspections monkeyList =
  let inspections = List.map monkeyList ~f:(fun x -> x.inspections) in
  match List.sort inspections ~compare:(fun x y -> -compare x y) with
  | x :: y :: _ -> x * y
  | _ -> 0

let rec play monkeyList times stressReliever =
  match times with
  | _ when times = 0 -> countInspections monkeyList
  | _ -> play (playRound monkeyList 0 stressReliever) (times - 1) stressReliever

let stressReliever stressLevel = stressLevel / 3

let highStressReliever stressLevel =
  stressLevel % (2 * 3 * 5 * 7 * 11 * 13 * 17 * 19 * 23)

(*-----------------------------------------------------------------------------
  -- Challenges
  -----------------------------------------------------------------------------*)

let result1 fileName =
  let monkeyList = parseMonkeys fileName in
  play monkeyList 20 stressReliever

let result2 fileName =
  let monkeyList = parseMonkeys fileName in
  play monkeyList 10_000 highStressReliever

(*-----------------------------------------------------------------------------
  -- Display
  -----------------------------------------------------------------------------*)

let result =
  let fileName = "./data/day11_input.txt" in
  "Day 11 — Result 1: "
  ^ string_of_int (result1 fileName)
  ^ "\n" ^ "Day 11 — Result 2: "
  ^ string_of_int (result2 fileName)
