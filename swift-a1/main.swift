//
//  main.swift
//  SheungKit_A1
//
//  Created by Simon Chan on 2024-05-10.
//

import Foundation

var player: [(name:String, score: Int)] = []

print("Welcome to Zoo Escape!")

func zooEscape(player: [(name:String, score:Int)]){
   var player = player

    print("\nMENU:")
    print("\t1. Start game")
    print("\t2. Show scoreboard")
    print("Choose an option:", terminator: "")
    
    if let choice = readLine(), let option = Int(choice){
        switch option{
        case 1:
            player.removeAll()
            print("\nTwo Player Game\n")
            for i in 1...2 {
                print("Enter player \(i) name: ", terminator: "")
                if let name = readLine(){
                    player.append((name, 0))
                }
            }
            startGame(player)
        case 2:
            showScoreboard(player)
        default:
            print("Invalid option.")
        }
    }
}

func startGame(_ player: [(name:String, score:Int)]){
    var player = player
    var turn = 0
    var neighbourhood: [String:Int] = [:]
    
    turn = Int.random(in: 0..<2)
    print("\n\(player[turn].name) will go first.\n")
    
    let neighbourhoodName = ["Brooklyn", "Queens", "Manhattan"]
    for result in neighbourhoodName{
        neighbourhood[result] = [3,5,7].randomElement()
    }
    
    print("Escaped Animal List")
    print("---------")
    for i in 0..<neighbourhoodName.count{
        let name = neighbourhoodName[i]
        if let count = neighbourhood[name]{
            print("\(i+1):\(name) (\(count)): " + String(repeating: "*", count: count))
        }
    }
    
    var isGameOver = false
    while !isGameOver{
        let currPlayer = player[turn]
        print("\n\(currPlayer.name)'s Turn:\n")
        
        repeat{
            print("● Which neighbourhood do you want to visit?", terminator: "")
            if let selectedNeighbourhood = readLine(), let neighourhoodIndex = Int(selectedNeighbourhood), neighourhoodIndex >= 1 && neighourhoodIndex <= neighbourhoodName.count {
                let result = neighbourhoodName[neighourhoodIndex - 1]
                
                if neighbourhood[result] == 0 {
                    print("● Sorry, there are no animals remaining in \(result). Try again.")
                    continue
                }
                repeat{
                    print("● How many animals do you want to capture?", terminator: "")
                    if let animalsCountbyInput = readLine(), let animalsCount = Int(animalsCountbyInput){
                        if animalsCount > 0 && animalsCount <= neighbourhood[result]!{
                            neighbourhood[result]! -= animalsCount
                            print("\nEscaped Animal List (Updated):")
                            print("-----------------------------------")
                            for i in 0..<neighbourhoodName.count{
                                let name = neighbourhoodName[i]
                                if let count = neighbourhood[name]{
                                    print("\(i+1): \(name) (\(count)): " + String(repeating: "*", count: count))
                                }
                            }
                            
                            isGameOver = true
                            for (_, count) in neighbourhood{
                                if count > 0 {
                                    isGameOver = false
                                    break
                                }
                            }
                            if isGameOver{
                                print("\nGame Over!\n")
                                print("Congratulations, \(currPlayer.name)! You won the game !\n")
                                player[turn].score += 1
                                
                            } else{
                                turn = (turn + 1)%2
                            }
                            break
                        } else if animalsCount == 0{
                            print("● You must select minimum 1 animal.")
                        } else{
                            print("● Sorry, \(result) does not have \(animalsCount) animals.")
                        }
                    } else{
                        print("● Invalid input.")
                    }
                } while true
                break
            } else{
                print("Sorry, that neighbourhood does not exist.")
            }
        } while true
    }
    print("Do you want to play again?")
    print("\t1. Yes")
    print("\t2. No")
    print("Choose an option:", terminator: "")
    if let choice = readLine(), let option = Int(choice){
        switch option{
        case 1:
            startGame(player)
        case 2:
            zooEscape(player: player)
        default:
            print("Invalid option.")
        }
    }
}

func showScoreboard(_ player: [(name:String, score:Int)]){
    print("\nPlayer name Games won")
    for result in player{
        print("\(result.name) \(result.score)")
    }
}

zooEscape(player: player)
