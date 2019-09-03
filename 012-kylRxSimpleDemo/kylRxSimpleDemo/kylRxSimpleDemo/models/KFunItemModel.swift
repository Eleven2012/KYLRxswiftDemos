//
//  KFunItemModel.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/9/3.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import UIKit
import RxSwift
import HandyJSON
import RxDataSources
import Differentiator

class KFunItemModel: HandyJSON {
    
    var name:String = ""
    var iconPath:String = ""
    var className:String = ""
    var desc:String = ""
    
    required init() {
    }
    
}

struct KFunItemSectionModel {
    
    let name: String
    let gitHubID: String
    var image: UIImage?
    init(name: String, gitHubID: String) {
        self.name = name
        self.gitHubID = gitHubID
        image = UIImage(named: gitHubID)
    }
}

struct KFunItemSectionDataModel {
    var lgheader:Identity
    var items: [Item]
}

extension KFunItemSectionDataModel : SectionModelType{
    typealias Item = KFunItemSectionModel
    typealias Identity = String
    
    var identity: Identity {
        return lgheader
    }
    
    init(original: KFunItemSectionDataModel, items: [Item]) {
        self = original
        self.items = items
    }
    
}

class KSectionHighFunData {
    let sectionData = Observable.just([
        KFunItemSectionDataModel(lgheader: "A", items: [
            KFunItemSectionModel(name: "Alex V Bush", gitHubID: "alexvbush"),
            KFunItemSectionModel(name: "Andrew Breckenridge", gitHubID: "AndrewSB"),
            KFunItemSectionModel(name: "Anton Efimenko", gitHubID: "reloni"),
            KFunItemSectionModel(name: "Ash Furrow", gitHubID: "ashfurrow"),
            ]),
        KFunItemSectionDataModel(lgheader: "B", items: [
            KFunItemSectionModel(name: "Ben Emdon", gitHubID: "BenEmdon"),
            KFunItemSectionModel(name: "Bob Spryn", gitHubID: "sprynmr"),
            ])
        ])
}

class KSectionBaseFunData {
    let sectionData = Observable.just([
        KFunItemSectionDataModel(lgheader: "Rx基本使用", items: [
            KFunItemSectionModel(name: "基础使用篇--实例2.1", gitHubID: "2.1"),
            KFunItemSectionModel(name: "Andrew Breckenridge", gitHubID: "AndrewSB"),
            KFunItemSectionModel(name: "Anton Efimenko", gitHubID: "reloni"),
            KFunItemSectionModel(name: "Ash Furrow", gitHubID: "ashfurrow"),
            ]),
        KFunItemSectionDataModel(lgheader: "B", items: [
            KFunItemSectionModel(name: "Ben Emdon", gitHubID: "BenEmdon"),
            KFunItemSectionModel(name: "Bob Spryn", gitHubID: "sprynmr"),
            ])
        ])
}



class KHighFunData {
    var githubData : Observable<[SectionModel<String, KFunItemSectionModel>]> {
        get{
            return Observable.just(githubArray)
        }
    }
    let githubArray = [
        SectionModel(model: "A", items: [
            KFunItemSectionModel(name: "Alex V Bush", gitHubID: "alexvbush"),
            KFunItemSectionModel(name: "Andrew Breckenridge", gitHubID: "AndrewSB"),
            KFunItemSectionModel(name: "Anton Efimenko", gitHubID: "reloni"),
            KFunItemSectionModel(name: "Ash Furrow", gitHubID: "ashfurrow"),
            ]),
        SectionModel(model: "B", items: [
            KFunItemSectionModel(name: "Ben Emdon", gitHubID: "BenEmdon"),
            KFunItemSectionModel(name: "Bob Spryn", gitHubID: "sprynmr"),
            ]),
        SectionModel(model: "C", items: [
            KFunItemSectionModel(name: "Carlos García", gitHubID: "carlosypunto"),
            KFunItemSectionModel(name: "Cezary Kopacz", gitHubID: "CezaryKopacz"),
            KFunItemSectionModel(name: "Chris Jimenez", gitHubID: "PiXeL16"),
            KFunItemSectionModel(name: "Christian Tietze", gitHubID: "DivineDominion"),
            ]),
        SectionModel(model: "D", items: [
            KFunItemSectionModel(name: "だいちろ", gitHubID: "mokumoku"),
            KFunItemSectionModel(name: "David Alejandro", gitHubID: "davidlondono"),
            KFunItemSectionModel(name: "David Paschich", gitHubID: "dpassage"),
            ]),
        SectionModel(model: "E", items: [
            KFunItemSectionModel(name: "Esteban Torres", gitHubID: "esttorhe"),
            KFunItemSectionModel(name: "Evgeny Aleksandrov", gitHubID: "ealeksandrov"),
            ]),
        SectionModel(model: "F", items: [
            KFunItemSectionModel(name: "Florent Pillet", gitHubID: "fpillet"),
            KFunItemSectionModel(name: "Francis Chong", gitHubID: "siuying"),
            ]),
        SectionModel(model: "G", items: [
            KFunItemSectionModel(name: "Giorgos Tsiapaliokas", gitHubID: "terietor"),
            KFunItemSectionModel(name: "Guy Kahlon", gitHubID: "GuyKahlon"),
            KFunItemSectionModel(name: "Gwendal Roué", gitHubID: "groue"),
            ]),
        SectionModel(model: "H", items: [
            KFunItemSectionModel(name: "Hiroshi Kimura", gitHubID: "muukii"),
            ]),
        SectionModel(model: "I", items: [
            KFunItemSectionModel(name: "Ivan Bruel", gitHubID: "ivanbruel"),
            ]),
        SectionModel(model: "J", items: [
            KFunItemSectionModel(name: "Jeon Suyeol", gitHubID: "devxoul"),
            KFunItemSectionModel(name: "Jérôme Alves", gitHubID: "jegnux"),
            KFunItemSectionModel(name: "Jesse Farless", gitHubID: "solidcell"),
            KFunItemSectionModel(name: "Junior B.", gitHubID: "bontoJR"),
            KFunItemSectionModel(name: "Justin Swart", gitHubID: "justinswart"),
            ]),
        SectionModel(model: "K", items: [
            KFunItemSectionModel(name: "Karlo", gitHubID: "floskel"),
            KFunItemSectionModel(name: "Krunoslav Zaher", gitHubID: "kzaher"),
            ]),
        SectionModel(model: "L", items: [
            KFunItemSectionModel(name: "Laurin Brandner", gitHubID: "lbrndnr"),
            KFunItemSectionModel(name: "Lee Sun-Hyoup", gitHubID: "kciter"),
            KFunItemSectionModel(name: "Leo Picado", gitHubID: "leopic"),
            KFunItemSectionModel(name: "Libor Huspenina", gitHubID: "libec"),
            KFunItemSectionModel(name: "Lukas Lipka", gitHubID: "lipka"),
            KFunItemSectionModel(name: "Łukasz Mróz", gitHubID: "sunshinejr"),
            ]),
        SectionModel(model: "M", items: [
            KFunItemSectionModel(name: "Marin Todorov", gitHubID: "icanzilb"),
            KFunItemSectionModel(name: "Maurício Hanika", gitHubID: "mAu888"),
            KFunItemSectionModel(name: "Maximilian Alexander", gitHubID: "mbalex99"),
            ]),
        SectionModel(model: "N", items: [
            KFunItemSectionModel(name: "Nathan Kot", gitHubID: "nathankot"),
            ]),
        SectionModel(model: "O", items: [
            KFunItemSectionModel(name: "Orakaro", gitHubID: "DTVD"),
            KFunItemSectionModel(name: "Orta", gitHubID: "orta"),
            ]),
        SectionModel(model: "P", items: [
            KFunItemSectionModel(name: "Paweł Urbanek", gitHubID: "pawurb"),
            KFunItemSectionModel(name: "Pedro Piñera Buendía", gitHubID: "pepibumur"),
            KFunItemSectionModel(name: "PG Herveou", gitHubID: "pgherveou"),
            ]),
        SectionModel(model: "R", items: [
            KFunItemSectionModel(name: "Rui Costa", gitHubID: "ruipfcosta"),
            KFunItemSectionModel(name: "Ryo Fukuda", gitHubID: "yuzushioh")
            ]),
        SectionModel(model: "S", items: [
            KFunItemSectionModel(name: "Scott Gardner", gitHubID: "scotteg"),
            KFunItemSectionModel(name: "Scott Hoyt", gitHubID: "scottrhoyt"),
            KFunItemSectionModel(name: "Sendy Halim", gitHubID: "sendyhalim"),
            KFunItemSectionModel(name: "Serg Dort", gitHubID: "sergdort"),
            KFunItemSectionModel(name: "Shai Mishali", gitHubID: "freak4pc"),
            KFunItemSectionModel(name: "Shams Ahmed", gitHubID: "shams-ahmed"),
            KFunItemSectionModel(name: "Shenghan Chen", gitHubID: "zzdjk6"),
            KFunItemSectionModel(name: "Shunki Tan", gitHubID: "milkit"),
            KFunItemSectionModel(name: "Spiros Gerokostas", gitHubID: "sger"),
            KFunItemSectionModel(name: "Stefano Mondino", gitHubID: "stefanomondino")
            ]),
        SectionModel(model: "T", items: [
            KFunItemSectionModel(name: "Thane Gill", gitHubID: "thanegill"),
            KFunItemSectionModel(name: "Thomas Duplomb", gitHubID: "tomahh"),
            KFunItemSectionModel(name: "Tomasz Pikć", gitHubID: "pikciu"),
            KFunItemSectionModel(name: "Tony Arnold", gitHubID: "tonyarnold"),
            KFunItemSectionModel(name: "Torsten Curdt", gitHubID: "tcurdt")
            ]),
        SectionModel(model: "V", items: [
            KFunItemSectionModel(name: "Vladimir Burdukov", gitHubID: "chipp")
            ]),
        SectionModel(model: "W", items: [
            KFunItemSectionModel(name: "Wolfgang Lutz", gitHubID: "Lutzifer")
            ]),
        SectionModel(model: "X", items: [
            KFunItemSectionModel(name: "xixi197 Nova", gitHubID: "xixi197"),
            KFunItemSectionModel(name: "xixi198", gitHubID: "xixi198"),
            KFunItemSectionModel(name: "xixi199", gitHubID: "xixi199")
            
            ]),
        SectionModel(model: "Y", items: [
            KFunItemSectionModel(name: "Yongha Yoo", gitHubID: "inkyfox"),
            KFunItemSectionModel(name: "Yosuke Ishikawa", gitHubID: "ishkawa"),
            KFunItemSectionModel(name: "Yury Korolev", gitHubID: "yury"),
            KFunItemSectionModel(name: "Yury Ko", gitHubID: "yuryer")
            ]),
    ]
    
    
}
