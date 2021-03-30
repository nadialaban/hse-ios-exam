//
//  File.swift
//  SpellCheckerApp
//
//  Created by Nadia on 30.03.2021.
//
import Foundation

class MyDictionary {
    // MARK: -Words
    // Мне сказали захардкодить
    // Взяла слова отсюда: https://www.englishdom.com/blog/frukty-yagody-ovoshhi-orexi-i-krupy-na-anglijskom/
    fileprivate static var russianWords = ["яблоко","абрикос","авокадо",
                                "ананас", "банан", "бергамот",
                                "дуриан", "грейпфрут", "киви",
                                "лайм", "лимон", "локва",
                                "манго", "дыня", "нектарин",
                                "апельсин", "маракуйя", "папайя",
                                "персик", "груша", "хурма",
                                "ананас", "слива", "гранат",
                                "помело", "мандарин", "айва"]
    fileprivate static var englishWords = ["apple", "apricot", "avocado",
                                "pineapple", "banana", "bergamot",
                                "durian", "grapefruit", "kiwi",
                                "lime", "lemon", "loquat",
                                "mango", "melon", "nectarine",
                                "orange", "passion fruit",
                                "papaya", "peach", "pear",
                                "persimmon", "pineapple", "plum",
                                "pomegranate", "pomelo", "tangerine","quince"]
    
    // MARK: -Methods
    public static func checkWord(word: String) -> [String] {
        // Готовим слово к работе
        let preprocessedWord = Array(word.lowercased())
        // Будем считать, что это слово с опечаткой,
        // если в нем половина и меньше ошибок
        let permissedMistakes = word.count / 2
        
        // Проверяем в наших словарях
        let russian =  checkDict(word: preprocessedWord, dict: russianWords, permissedMistakes: permissedMistakes)
        let english = checkDict(word: preprocessedWord, dict: englishWords, permissedMistakes: permissedMistakes)
                
        var res: [String] = []
        res += veryUglySort(words: russian, permissedMistakes: permissedMistakes)
        res += veryUglySort(words: english, permissedMistakes: permissedMistakes)
        
        return res
    }
    
    fileprivate static func veryUglySort(words: [String: Int], permissedMistakes: Int) -> [String] {
        var res: [String] = []

        // Записываем в порядке увеличения количества ошибок
        for i in (0...permissedMistakes) {
            for word in words.keys {
                if words[word] == i {
                    res.append(word)
                    if i == 0 {
                        return res
                    }
                }
            }
        }
        
        return res
    }
    
    fileprivate static func checkDict(word: [Character], dict: [String], permissedMistakes: Int) -> [String : Int] {
        var res: [String : Int] = [:]

        for w in dict {
            let tmp = Array(w)
            for offset in (0...permissedMistakes) {
                var mistakes = offset
                for i in (0..<word.count) {
                    if i + offset > w.count - 1 || tmp[i + offset] != word[i] {
                        mistakes += 1
                    }
                }
                mistakes += offset + word.count < w.count ? w.count - offset - word.count - 1 : 0
                if mistakes <= permissedMistakes {
                    res.updateValue(mistakes, forKey: w)
                }
            }
        }
    
        return res
    }
}
