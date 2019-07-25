//
//  ViewController.swift
//  DIceDelegate
//
//  Created by Vimosoft on 24/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

protocol DiceGame { // 주사위 게임이 채택해야 하는 프로토콜
    
    var dice: Dice { get } // 주사위
    
    func play()            // 게임 플레이 메소드
    
}

protocol DiceGameDelegate: AnyObject {
    
    // 주사위 게임 추적할 델리게이트 프로토콜
    
    // AnyObject를 붙이면 클래스만 이 프로토콜을 채택할 수 있는 class-only 속성이 적용된다.
    
    func gameDidStart(_ game: DiceGame)
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    
    func gameDidEnd(_ game: DiceGame)
    
}



protocol RandomNumberGenerator { // 랜덤의 수 생성하는 것들이 채택하는 프로토콜.
    
    func random() -> Double
    
}



class LinearCongruentialGenerator: RandomNumberGenerator {
    
    // RandomNumberGenerator 프로토콜을 채택한 의사 난수를 생성하는 클래스
    
    var lastRandom = 42.0
    
    let m = 139968.0
    
    let a = 3877.0
    
    let c = 29573.0
    
    func random() -> Double { // 이 메소드 호출하면 반환값으로 난수 반환 하는 듯.
        
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        
        return lastRandom / m
        
    }
    
}



class Dice { //주사위를 표현하는 Dice 클래스.
    
    let sides: Int //주사위의 면.
    
    let generator: RandomNumberGenerator
    
    // 랜덤 수 생성기 프로토콜을 타입으로 가진다 함은?
    
    // RandomNumberGenerator 프로토콜을 채택하는 모든 타입(클래스나 구조체나..)의 인스턴스를 설정할 수 있는 것.
    
    // 인스턴스가 RandomNumberGenerator 프로토콜을 채택해야 한다는 것 외에는 별다른 제약사항은 없습니다.
    
    // 이 말은  이 프로토콜을 채택한 (예를들어) 클래스의 인스턴스만 generator 상수에 저장될 수 있다. 이 말.
    
    init(sides: Int, generator: RandomNumberGenerator) { // 초기 설정을 위한 초기화 함수.
        
        self.sides = sides
        
        self.generator = generator
        
    }
    
    func roll() -> Int { //주사위 굴리는 행위를 메소드로 표현한 것, 주사위에서 나온 랜덤한 수.
        
        return Int(generator.random() * Double(sides)) + 1 // 이 수식의 의미에 빠지지 않아도 됩니다. 확률론적 지식이 있어야 해요. 이것이 주사위 던저서 나온 랜덤한 수 라는 것만 알면 될듯.
        
    }
    
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class SnakesAndLadders: DiceGame { // 주사위 게임들이 채택하는 DiceGame 프로토콜을 채택한 뱀과 사다리게임.
    
    let finalSquare = 25 // 스코어는 25점 까지네요.
    
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    
    // 6면을 가지고 있고 난수생성기는 LinearCongruentialGenerator 방식을 쓰려고 그의 인스턴스를 넣어주었네요.
    
    var square = 0 // 칸을 표현하는 변수입니다. ( 정사각형의 칸이 있는 보드게임 이거든요. )
    
    var board: [Int] // 보드게임 이기 때문에 보드를 표현하는 배열입니다.
    
    init() {
        
        board = Array(repeating: 0, count: finalSquare + 1) // 배열의 값은 0, 그 값으로 26개의 배열을 생성한다는 의미
        
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        
        //특정 칸에 사다리 혹은 뱀이 있는 게임이기 때문에
        
        //사다리가 있는 칸은 위로 올라갈 수 있게 양의 정수, 뱀이 있는 쪽은 아래로 내려가게 음수 설정해주기.
        
    }
    
    weak var delegate: DiceGameDelegate?
    
    // DiceGameDelegate를 타입으로 가지는 delegate 프로퍼티
    
    // 옵셔널인 이유 : 게임 플레이에 지장이 없어. 인스턴스 받는 곳에서 선택할 수 있게 해 주려고.
    
    // DiceGameDelegate 프로토콜 class-only 이기 때문에 '강한 참조 사이클'을 예방하려면 weak 붙여주어야 함.
    
    // weak 키워드는 약한참조를 하라는 의미 ( 강한 참조 사이클 이라는 문제때문에 이 키워드를 붙이는데 아직 학습할 단계가 아닙니다.)
    
    // class-only 인데 프로퍼티가 프로토콜을 타입으로 가질 수 있냐는 의문이 생길 수 있겠죠?
    
    // class-only 는 이 프로토콜을 타입으로 가지는 것에서 범위를 제한하는 것이 아니라, 이 프로토콜을 채택하는 타입이 클래스로 제한된다는 뜻입니다.
    
    func play() {
        
        // SnakesAndLadders 이라는 주사위 게임의 플레이를 메소드로 표현했네요.
        
        // 이 메소드를 호출하면 게임을 플레이 하는 것이겠죠?
        
        square = 0 // 0 번째 칸에서 시작하는 보드게임.
        
        delegate?.gameDidStart(self) // 게임 시작했다는 메소드를 호출해 줍니다.
        
        gameLoop: while square != finalSquare { // 점수가 마지막 점수까지 도달해야 하니까!
            
            let diceRoll = dice.roll() // 주사위 떤지기! (1~6 의 수가 나오겠죠?)
            
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll) // 주사위 턴이 시작될 때.
            
            switch square + diceRoll { //게임 끝낼지 더 갈지 체크합니다.
                
            case finalSquare:
                
                break gameLoop // 이전 점수와 주사위 값을 더한 값인 현재 내 점수가 최종 점수랑 같다면 끝.(승리)
                
            case let newSquare where newSquare > finalSquare:
                
                continue gameLoop // 현재 점수가 최종 점수보다 크면 계속 진행 (일치해야 이기는 게임임.)
                
            default:
                
                square += diceRoll // 점수 높아지고
                
                square += board[square] //뱀 만나서 점수 낮아지게 해야겠지뭐.
                
            }
            
        }
        
        delegate?.gameDidEnd(self) // 게임 끝낫다
        
    }
    
}



class DiceGameTracker: DiceGameDelegate {
    
    // DiceGameDelegate 프로토콜(클래스만 채택할 수 있는 프로퍼티임.)을 채택한 DiceGameTracker 클래스
    
    // 역할을 다시 알려주자면 게임의 진행과정 추적 에 있다. 추적!
    
    var numberOfTurns = 0 // 턴 수.
    
    func gameDidStart(_ game: DiceGame) { //시작할 때 추적해서 아래 내용을 수행.
        
        numberOfTurns = 0
        
        if game is SnakesAndLadders { // SnakesAndLadders 클래스의 인스턴스가 매개변수로 들어오면 (인스턴스 체크.)
            
            print("Started a new game of Snakes and Ladders")
            
        }
        
        print("The game is using a \(game.dice.sides)-sided dice")
        
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) { //새로운 턴일 때 추적해서 아래 내용 수행
        
        numberOfTurns += 1 // 턴 수 체크.
        
        print("Rolled a \(diceRoll)")
        
    }
    
    func gameDidEnd(_ game: DiceGame) { // 게임 오버 일때 추적해서 아래꺼 수행.
        
        print("The game lasted for \(numberOfTurns) turns") // 몇 턴으로 게임 오버됬는지 출력하면서 엔딩.
        
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tracker = DiceGameTracker() // DiceGameDelegate를 채택한 DiceGameTracker 클래스의 인스턴스
        
        let game = SnakesAndLadders() // DiceGame 프로토콜을 채택한 SnakesAndLadders 클래스 인스턴스
        
        game.delegate = tracker
        
        // SnakesAndLadders 클래스의 delegate 프로퍼티에 DiceGameDelegate를 채택한 클래스의 인스턴스인 tracker 대입.
        
        game.play()
    }


}

