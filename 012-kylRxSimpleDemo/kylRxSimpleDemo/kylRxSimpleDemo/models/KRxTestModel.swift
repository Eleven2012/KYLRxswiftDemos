//
//  KRxTestModel.swift
//  kylRxSimpleDemo
//
//  Created by yulu kong on 2019/9/3.
//  Copyright © 2019 yulu kong. All rights reserved.
//

import Foundation
import HandyJSON
import RxSwift
import RxDataSources
import Differentiator

class KRxTestModel: HandyJSON {
    
    var name:String = ""
    var iconPath:String = ""
    var className:String = ""
    var desc:String = ""
    
    required init() {
    }
    
}

struct KRxTestSectionModel {
    
    let name: String
    let gitHubID: String
    var image: UIImage?
    init(name: String, gitHubID: String) {
        self.name = name
        self.gitHubID = gitHubID
        image = UIImage(named: gitHubID)
    }
}

struct KRxTestSectionDataModel {
    var lgheader:Identity
    var items: [Item]
}

extension KRxTestSectionDataModel : SectionModelType{
    typealias Item = KRxTestSectionModel
    typealias Identity = String
    
    var identity: Identity {
        return lgheader
    }
    
    init(original: KRxTestSectionDataModel, items: [Item]) {
        self = original
        self.items = items
    }
    
}

class KRxTestSectionGithubData {
    let sectionData = Observable.just([
        KRxTestSectionDataModel(lgheader: "A", items: [
            KRxTestSectionModel(name: "Alex V Bush", gitHubID: "alexvbush"),
            KRxTestSectionModel(name: "Andrew Breckenridge", gitHubID: "AndrewSB"),
            KRxTestSectionModel(name: "Anton Efimenko", gitHubID: "reloni"),
            KRxTestSectionModel(name: "Ash Furrow", gitHubID: "ashfurrow"),
            ]),
        KRxTestSectionDataModel(lgheader: "B", items: [
            KRxTestSectionModel(name: "Ben Emdon", gitHubID: "BenEmdon"),
            KRxTestSectionModel(name: "Bob Spryn", gitHubID: "sprynmr"),
            ])
        ])
}

class KRxTestGithubData {
    var githubData : Observable<[SectionModel<String, KRxTestSectionModel>]> {
        get{
            return Observable.just(githubArray)
        }
    }
    let githubArray = [
        SectionModel(model: "A", items: [
            KRxTestSectionModel(name: "Alex V Bush", gitHubID: "alexvbush"),
            KRxTestSectionModel(name: "Andrew Breckenridge", gitHubID: "AndrewSB"),
            KRxTestSectionModel(name: "Anton Efimenko", gitHubID: "reloni"),
            KRxTestSectionModel(name: "Ash Furrow", gitHubID: "ashfurrow"),
            ]),
        SectionModel(model: "B", items: [
            KRxTestSectionModel(name: "Ben Emdon", gitHubID: "BenEmdon"),
            KRxTestSectionModel(name: "Bob Spryn", gitHubID: "sprynmr"),
            ]),
        SectionModel(model: "C", items: [
            KRxTestSectionModel(name: "Carlos García", gitHubID: "carlosypunto"),
            KRxTestSectionModel(name: "Cezary Kopacz", gitHubID: "CezaryKopacz"),
            KRxTestSectionModel(name: "Chris Jimenez", gitHubID: "PiXeL16"),
            KRxTestSectionModel(name: "Christian Tietze", gitHubID: "DivineDominion"),
            ]),
        SectionModel(model: "D", items: [
            KRxTestSectionModel(name: "だいちろ", gitHubID: "mokumoku"),
            KRxTestSectionModel(name: "David Alejandro", gitHubID: "davidlondono"),
            KRxTestSectionModel(name: "David Paschich", gitHubID: "dpassage"),
            ]),
        SectionModel(model: "E", items: [
            KRxTestSectionModel(name: "Esteban Torres", gitHubID: "esttorhe"),
            KRxTestSectionModel(name: "Evgeny Aleksandrov", gitHubID: "ealeksandrov"),
            ]),
        SectionModel(model: "F", items: [
            KRxTestSectionModel(name: "Florent Pillet", gitHubID: "fpillet"),
            KRxTestSectionModel(name: "Francis Chong", gitHubID: "siuying"),
            ]),
        SectionModel(model: "G", items: [
            KRxTestSectionModel(name: "Giorgos Tsiapaliokas", gitHubID: "terietor"),
            KRxTestSectionModel(name: "Guy Kahlon", gitHubID: "GuyKahlon"),
            KRxTestSectionModel(name: "Gwendal Roué", gitHubID: "groue"),
            ]),
        SectionModel(model: "H", items: [
            KRxTestSectionModel(name: "Hiroshi Kimura", gitHubID: "muukii"),
            ]),
        SectionModel(model: "I", items: [
            KRxTestSectionModel(name: "Ivan Bruel", gitHubID: "ivanbruel"),
            ]),
        SectionModel(model: "J", items: [
            KRxTestSectionModel(name: "Jeon Suyeol", gitHubID: "devxoul"),
            KRxTestSectionModel(name: "Jérôme Alves", gitHubID: "jegnux"),
            KRxTestSectionModel(name: "Jesse Farless", gitHubID: "solidcell"),
            KRxTestSectionModel(name: "Junior B.", gitHubID: "bontoJR"),
            KRxTestSectionModel(name: "Justin Swart", gitHubID: "justinswart"),
            ]),
        SectionModel(model: "K", items: [
            KRxTestSectionModel(name: "Karlo", gitHubID: "floskel"),
            KRxTestSectionModel(name: "Krunoslav Zaher", gitHubID: "kzaher"),
            ]),
        SectionModel(model: "L", items: [
            KRxTestSectionModel(name: "Laurin Brandner", gitHubID: "lbrndnr"),
            KRxTestSectionModel(name: "Lee Sun-Hyoup", gitHubID: "kciter"),
            KRxTestSectionModel(name: "Leo Picado", gitHubID: "leopic"),
            KRxTestSectionModel(name: "Libor Huspenina", gitHubID: "libec"),
            KRxTestSectionModel(name: "Lukas Lipka", gitHubID: "lipka"),
            KRxTestSectionModel(name: "Łukasz Mróz", gitHubID: "sunshinejr"),
            ]),
        SectionModel(model: "M", items: [
            KRxTestSectionModel(name: "Marin Todorov", gitHubID: "icanzilb"),
            KRxTestSectionModel(name: "Maurício Hanika", gitHubID: "mAu888"),
            KRxTestSectionModel(name: "Maximilian Alexander", gitHubID: "mbalex99"),
            ]),
        SectionModel(model: "N", items: [
            KRxTestSectionModel(name: "Nathan Kot", gitHubID: "nathankot"),
            ]),
        SectionModel(model: "O", items: [
            KRxTestSectionModel(name: "Orakaro", gitHubID: "DTVD"),
            KRxTestSectionModel(name: "Orta", gitHubID: "orta"),
            ]),
        SectionModel(model: "P", items: [
            KRxTestSectionModel(name: "Paweł Urbanek", gitHubID: "pawurb"),
            KRxTestSectionModel(name: "Pedro Piñera Buendía", gitHubID: "pepibumur"),
            KRxTestSectionModel(name: "PG Herveou", gitHubID: "pgherveou"),
            ]),
        SectionModel(model: "R", items: [
            KRxTestSectionModel(name: "Rui Costa", gitHubID: "ruipfcosta"),
            KRxTestSectionModel(name: "Ryo Fukuda", gitHubID: "yuzushioh")
            ]),
        SectionModel(model: "S", items: [
            KRxTestSectionModel(name: "Scott Gardner", gitHubID: "scotteg"),
            KRxTestSectionModel(name: "Scott Hoyt", gitHubID: "scottrhoyt"),
            KRxTestSectionModel(name: "Sendy Halim", gitHubID: "sendyhalim"),
            KRxTestSectionModel(name: "Serg Dort", gitHubID: "sergdort"),
            KRxTestSectionModel(name: "Shai Mishali", gitHubID: "freak4pc"),
            KRxTestSectionModel(name: "Shams Ahmed", gitHubID: "shams-ahmed"),
            KRxTestSectionModel(name: "Shenghan Chen", gitHubID: "zzdjk6"),
            KRxTestSectionModel(name: "Shunki Tan", gitHubID: "milkit"),
            KRxTestSectionModel(name: "Spiros Gerokostas", gitHubID: "sger"),
            KRxTestSectionModel(name: "Stefano Mondino", gitHubID: "stefanomondino")
            ]),
        SectionModel(model: "T", items: [
            KRxTestSectionModel(name: "Thane Gill", gitHubID: "thanegill"),
            KRxTestSectionModel(name: "Thomas Duplomb", gitHubID: "tomahh"),
            KRxTestSectionModel(name: "Tomasz Pikć", gitHubID: "pikciu"),
            KRxTestSectionModel(name: "Tony Arnold", gitHubID: "tonyarnold"),
            KRxTestSectionModel(name: "Torsten Curdt", gitHubID: "tcurdt")
            ]),
        SectionModel(model: "V", items: [
            KRxTestSectionModel(name: "Vladimir Burdukov", gitHubID: "chipp")
            ]),
        SectionModel(model: "W", items: [
            KRxTestSectionModel(name: "Wolfgang Lutz", gitHubID: "Lutzifer")
            ]),
        SectionModel(model: "X", items: [
            KRxTestSectionModel(name: "xixi197 Nova", gitHubID: "xixi197"),
            KRxTestSectionModel(name: "xixi198", gitHubID: "xixi198"),
            KRxTestSectionModel(name: "xixi199", gitHubID: "xixi199")
            
            ]),
        SectionModel(model: "Y", items: [
            KRxTestSectionModel(name: "Yongha Yoo", gitHubID: "inkyfox"),
            KRxTestSectionModel(name: "Yosuke Ishikawa", gitHubID: "ishkawa"),
            KRxTestSectionModel(name: "Yury Korolev", gitHubID: "yury"),
            KRxTestSectionModel(name: "Yury Ko", gitHubID: "yuryer")
            ]),
    ]
    
    
}
