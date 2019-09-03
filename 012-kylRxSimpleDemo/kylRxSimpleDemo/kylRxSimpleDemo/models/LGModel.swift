//
//  LGModel.swift
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

class LGModel: HandyJSON {
    
    var name:String = ""
    var iconPath:String = ""
    var className:String = ""
    
    required init() {
    }
    
}

struct LGSectionModel {
    
    let name: String
    let gitHubID: String
    var image: UIImage?
    init(name: String, gitHubID: String) {
        self.name = name
        self.gitHubID = gitHubID
        image = UIImage(named: gitHubID)
    }
}

struct LGSectionDataModel {
    var lgheader:Identity
    var items: [Item]
}

extension LGSectionDataModel : SectionModelType{
    typealias Item = LGSectionModel
    typealias Identity = String
    
    var identity: Identity {
        return lgheader
    }
    
    init(original: LGSectionDataModel, items: [Item]) {
        self = original
        self.items = items
    }
    
}

class LGSectionGithubData {
    let sectionData = Observable.just([
        LGSectionDataModel(lgheader: "A", items: [
            LGSectionModel(name: "Alex V Bush", gitHubID: "alexvbush"),
            LGSectionModel(name: "Andrew Breckenridge", gitHubID: "AndrewSB"),
            LGSectionModel(name: "Anton Efimenko", gitHubID: "reloni"),
            LGSectionModel(name: "Ash Furrow", gitHubID: "ashfurrow"),
            ]),
        LGSectionDataModel(lgheader: "B", items: [
            LGSectionModel(name: "Ben Emdon", gitHubID: "BenEmdon"),
            LGSectionModel(name: "Bob Spryn", gitHubID: "sprynmr"),
            ])
        ])
}

class LGGithubData {
    var githubData : Observable<[SectionModel<String, LGSectionModel>]> {
        get{
            return Observable.just(githubArray)
        }
    }
    let githubArray = [
        SectionModel(model: "A", items: [
            LGSectionModel(name: "Alex V Bush", gitHubID: "alexvbush"),
            LGSectionModel(name: "Andrew Breckenridge", gitHubID: "AndrewSB"),
            LGSectionModel(name: "Anton Efimenko", gitHubID: "reloni"),
            LGSectionModel(name: "Ash Furrow", gitHubID: "ashfurrow"),
            ]),
        SectionModel(model: "B", items: [
            LGSectionModel(name: "Ben Emdon", gitHubID: "BenEmdon"),
            LGSectionModel(name: "Bob Spryn", gitHubID: "sprynmr"),
            ]),
        SectionModel(model: "C", items: [
            LGSectionModel(name: "Carlos García", gitHubID: "carlosypunto"),
            LGSectionModel(name: "Cezary Kopacz", gitHubID: "CezaryKopacz"),
            LGSectionModel(name: "Chris Jimenez", gitHubID: "PiXeL16"),
            LGSectionModel(name: "Christian Tietze", gitHubID: "DivineDominion"),
            ]),
        SectionModel(model: "D", items: [
            LGSectionModel(name: "だいちろ", gitHubID: "mokumoku"),
            LGSectionModel(name: "David Alejandro", gitHubID: "davidlondono"),
            LGSectionModel(name: "David Paschich", gitHubID: "dpassage"),
            ]),
        SectionModel(model: "E", items: [
            LGSectionModel(name: "Esteban Torres", gitHubID: "esttorhe"),
            LGSectionModel(name: "Evgeny Aleksandrov", gitHubID: "ealeksandrov"),
            ]),
        SectionModel(model: "F", items: [
            LGSectionModel(name: "Florent Pillet", gitHubID: "fpillet"),
            LGSectionModel(name: "Francis Chong", gitHubID: "siuying"),
            ]),
        SectionModel(model: "G", items: [
            LGSectionModel(name: "Giorgos Tsiapaliokas", gitHubID: "terietor"),
            LGSectionModel(name: "Guy Kahlon", gitHubID: "GuyKahlon"),
            LGSectionModel(name: "Gwendal Roué", gitHubID: "groue"),
            ]),
        SectionModel(model: "H", items: [
            LGSectionModel(name: "Hiroshi Kimura", gitHubID: "muukii"),
            ]),
        SectionModel(model: "I", items: [
            LGSectionModel(name: "Ivan Bruel", gitHubID: "ivanbruel"),
            ]),
        SectionModel(model: "J", items: [
            LGSectionModel(name: "Jeon Suyeol", gitHubID: "devxoul"),
            LGSectionModel(name: "Jérôme Alves", gitHubID: "jegnux"),
            LGSectionModel(name: "Jesse Farless", gitHubID: "solidcell"),
            LGSectionModel(name: "Junior B.", gitHubID: "bontoJR"),
            LGSectionModel(name: "Justin Swart", gitHubID: "justinswart"),
            ]),
        SectionModel(model: "K", items: [
            LGSectionModel(name: "Karlo", gitHubID: "floskel"),
            LGSectionModel(name: "Krunoslav Zaher", gitHubID: "kzaher"),
            ]),
        SectionModel(model: "L", items: [
            LGSectionModel(name: "Laurin Brandner", gitHubID: "lbrndnr"),
            LGSectionModel(name: "Lee Sun-Hyoup", gitHubID: "kciter"),
            LGSectionModel(name: "Leo Picado", gitHubID: "leopic"),
            LGSectionModel(name: "Libor Huspenina", gitHubID: "libec"),
            LGSectionModel(name: "Lukas Lipka", gitHubID: "lipka"),
            LGSectionModel(name: "Łukasz Mróz", gitHubID: "sunshinejr"),
            ]),
        SectionModel(model: "M", items: [
            LGSectionModel(name: "Marin Todorov", gitHubID: "icanzilb"),
            LGSectionModel(name: "Maurício Hanika", gitHubID: "mAu888"),
            LGSectionModel(name: "Maximilian Alexander", gitHubID: "mbalex99"),
            ]),
        SectionModel(model: "N", items: [
            LGSectionModel(name: "Nathan Kot", gitHubID: "nathankot"),
            ]),
        SectionModel(model: "O", items: [
            LGSectionModel(name: "Orakaro", gitHubID: "DTVD"),
            LGSectionModel(name: "Orta", gitHubID: "orta"),
            ]),
        SectionModel(model: "P", items: [
            LGSectionModel(name: "Paweł Urbanek", gitHubID: "pawurb"),
            LGSectionModel(name: "Pedro Piñera Buendía", gitHubID: "pepibumur"),
            LGSectionModel(name: "PG Herveou", gitHubID: "pgherveou"),
            ]),
        SectionModel(model: "R", items: [
            LGSectionModel(name: "Rui Costa", gitHubID: "ruipfcosta"),
            LGSectionModel(name: "Ryo Fukuda", gitHubID: "yuzushioh")
            ]),
        SectionModel(model: "S", items: [
            LGSectionModel(name: "Scott Gardner", gitHubID: "scotteg"),
            LGSectionModel(name: "Scott Hoyt", gitHubID: "scottrhoyt"),
            LGSectionModel(name: "Sendy Halim", gitHubID: "sendyhalim"),
            LGSectionModel(name: "Serg Dort", gitHubID: "sergdort"),
            LGSectionModel(name: "Shai Mishali", gitHubID: "freak4pc"),
            LGSectionModel(name: "Shams Ahmed", gitHubID: "shams-ahmed"),
            LGSectionModel(name: "Shenghan Chen", gitHubID: "zzdjk6"),
            LGSectionModel(name: "Shunki Tan", gitHubID: "milkit"),
            LGSectionModel(name: "Spiros Gerokostas", gitHubID: "sger"),
            LGSectionModel(name: "Stefano Mondino", gitHubID: "stefanomondino")
            ]),
        SectionModel(model: "T", items: [
            LGSectionModel(name: "Thane Gill", gitHubID: "thanegill"),
            LGSectionModel(name: "Thomas Duplomb", gitHubID: "tomahh"),
            LGSectionModel(name: "Tomasz Pikć", gitHubID: "pikciu"),
            LGSectionModel(name: "Tony Arnold", gitHubID: "tonyarnold"),
            LGSectionModel(name: "Torsten Curdt", gitHubID: "tcurdt")
            ]),
        SectionModel(model: "V", items: [
            LGSectionModel(name: "Vladimir Burdukov", gitHubID: "chipp")
            ]),
        SectionModel(model: "W", items: [
            LGSectionModel(name: "Wolfgang Lutz", gitHubID: "Lutzifer")
            ]),
        SectionModel(model: "X", items: [
            LGSectionModel(name: "xixi197 Nova", gitHubID: "xixi197"),
            LGSectionModel(name: "xixi198", gitHubID: "xixi198"),
            LGSectionModel(name: "xixi199", gitHubID: "xixi199")
            
            ]),
        SectionModel(model: "Y", items: [
            LGSectionModel(name: "Yongha Yoo", gitHubID: "inkyfox"),
            LGSectionModel(name: "Yosuke Ishikawa", gitHubID: "ishkawa"),
            LGSectionModel(name: "Yury Korolev", gitHubID: "yury"),
            LGSectionModel(name: "Yury Ko", gitHubID: "yuryer")
            ]),
    ]
    
    
}
