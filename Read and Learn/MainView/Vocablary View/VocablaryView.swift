//
//  VocablaryView.swift
//  Read and Learn
//
//  Created by Mohesn Qaysi on 7/20/23.
//

import SwiftUI
import DesignSystem

struct WordData: Codable {
    var words: [String: String]
}

struct Question: Codable {
    var text: String
    var options: [String]
    var correctOption: String
}

struct VocablaryView: View {
    @State private var questions: [Question] = []
    @State private var currentQuestionIndex = 0
    @State private var showResult = false
    @State private var disabaleNextButton = true
    @State private var optionStates: [OptionState] = []

    var body: some View {
        VStack(spacing: 30) {
            if currentQuestionIndex < questions.count {
                VStack {
                    Text("Select The Correct Answer")
                        .font(.title3)
                        .bold()
                        .lineLimit(3)
                        .foregroundColor(Palette.backgroundSunset.color)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(minHeight: 50, maxHeight: .infinity)
                    
                    Text(questions[currentQuestionIndex].text)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(minHeight: 80, maxHeight: .infinity)
                        .lineLimit(5)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(
                            Palette.backgroundSunsetLightest.color
                        )
                        .cornerRadius(10)
                }
                .animation(.easeOut(duration: 0.2), value: questions[currentQuestionIndex].text)

                VStack(spacing: 60) {
                    LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading, spacing: 20) {
                        ForEach(questions[currentQuestionIndex].options.indices, id: \.self) { index in
                            Button(action: {
                                self.selectOption(index)
                            }) {
                                Text(questions[currentQuestionIndex].options[index].capitalized)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.black)
                                    .bold()
                                    .background(
                                        self.optionStates[index].color
                                    )
                                    .cornerRadius(10)
                            }
                            .disabled(!disabaleNextButton)
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Button(action: {
                        self.showNextQuestion()
                        disabaleNextButton.toggle()
                    }) {
                        Text("Next Question")
                            .frame(minWidth: 0, maxWidth: .infinity) // Fix button size to fit the text
                            .padding()
                            .foregroundColor(.white)
                            .bold()
                            .background(
                                Palette.backgroundSunset.color
                            )
                            .cornerRadius(10)
                    }
                    .animation(.linear(duration: 0.2), value: disabaleNextButton)
                    .disabled(disabaleNextButton)
                    .opacity(disabaleNextButton ? 0.4 : 1.0)
                }
                .padding(.bottom, 50)
            } else {
                Text("Quiz Completed!")
            }
        }
        .padding()
        .onAppear {
            loadQuestionsFromJSON()
        }
        .alert(isPresented: $showResult) {
            Alert(
                title: Text("Result"),
                message: Text("Your answer is \(correctAnswer ? "correct! 😊✅" : "wrong! ❌")"),
                dismissButton: .default(Text("OK")) {
                    disabaleNextButton.toggle()
//                    self.showNextQuestion()
                }
            )
        }
    }

    private enum OptionState {
        case unselected
        case correct
        case wrong
        var color: Color {
            switch self {
            case .unselected: return Palette.basicBlack.color.opacity(0.2)
            case .correct: return Palette.backgroundGreen.color
            case .wrong: return  Palette.backgroundRed.color
            }
        }
    }

    @State private var correctAnswer = false
    @State private var wordData: WordData? // Variable to hold the parsed JSON data

    func loadQuestionsFromJSON() {

        if let data = jsonString.data(using: .utf8) {
            do {
                wordData = try JSONDecoder().decode(WordData.self, from: data)
                createQuestions()
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }

    func createQuestions() {
        let words = wordData?.words.keys.shuffled() ?? []
        let chunkSize = 4
        for i in stride(from: 0, to: words.count, by: chunkSize) {
            let endIndex = min(i + chunkSize, words.count)
            let chunk = Array(words[i..<endIndex])
            let correctOption = chunk.randomElement() ?? ""
            let question = Question(text: wordData?.words[correctOption] ?? "",
                                    options: chunk.map { $0 },
                                    correctOption: correctOption)
            questions.append(question)
        }
        optionStates = Array(repeating: .unselected, count: chunkSize)
    }

    func selectOption(_ index: Int) {
        let selectedOption = questions[currentQuestionIndex].options[index]
        let correctOption = questions[currentQuestionIndex].correctOption

        optionStates = questions[currentQuestionIndex].options.enumerated().map { (i, option) in
            if option == correctOption {
                return .correct
            } else if i == index {
                return .wrong
            } else {
                return .unselected
            }
        }

        correctAnswer = selectedOption == correctOption
        showResult = true
    }

    func showNextQuestion() {
        currentQuestionIndex += 1
        correctAnswer = false
        optionStates.removeAll()
        if currentQuestionIndex < questions.count {
            createQuestions()
        }
    }
}

struct VocablaryView_Previews: PreviewProvider {
    static var previews: some View {
        VocablaryView()
    }
}


let jsonString = """
{
    "words":
        {
            "abandon": "to leave behind or give up completely; to desert",
            "access": "the ability or right to approach, enter, or use",
            "accompany": "to go along with, usually for assistance or companionship",
            "accurate": "free from errors or mistakes; precise; correct",
            "achieve": "to successfully reach a goal or accomplish a task",
            "acquire": "to gain or obtain something through effort or action",
            "adapt": "to adjust or modify to fit new conditions or circumstances",
            "adequate": "sufficient or suitable for a specific purpose",
            "adjust": "to alter or change in order to achieve proper alignment or function",
            "administration": "the management and organization of a government, business, or institution",
            "adult": "a fully grown or developed person or animal",
            "affect": "to produce a change or influence on something",
            "aid": "assistance or support provided to someone or something in need",
            "alternative": "an option or choice that is different from the usual one",
            "amend": "to make corrections or changes to a document or law",
            "analyze": "to examine and study something in detail",
            "annual": "occurring once every year",
            "apparent": "clearly visible or understood; obvious",
            "appreciate": "to recognize the value or worth of something or someone",
            "approach": "to come near or nearer to something or someone",
            "appropriate": "suitable or proper for a particular situation",
            "approximate": "close to the actual, but not completely accurate",
            "area": "a specific geographic region or space",
            "aspect": "a particular part or feature of something",
            "assign": "to designate or allocate a task or responsibility to someone",
            "assist": "to help or aid in accomplishing a task or goal",
            "assume": "to accept as true without sufficient evidence",
            "assure": "to give confidence or make certain of something",
            "attach": "to fasten or join one thing to another",
            "attitude": "a person's outlook or perspective on a particular matter",
            "author": "a person who writes or creates literary, artistic, or scholarly works",
            "authority": "the power or right to give orders, make decisions, or enforce obedience",
            "available": "accessible or obtainable; ready for use",
            "aware": "having knowledge or consciousness of something",
            "benefit": "an advantage or reward gained from something",
            "bond": "a connection or relationship between people or things",
            "brief": "short in duration or concise in expression",
            "capable": "having the ability or capacity to do something",
            "capacity": "the maximum amount that something can contain or produce",
            "category": "a group of people or things having similar characteristics",
            "cease": "to stop or discontinue an action",
            "challenge": "a difficult task or situation that requires effort to overcome",
            "channel": "a medium through which something is conveyed or transmitted",
            "chapter": "a division or section of a book or other written work",
            "chart": "a visual representation of data or information",
            "chemical": "relating to or produced by the use of chemicals",
            "circumstance": "a condition or fact that affects a situation",
            "civil": "relating to the ordinary citizens and their rights and duties",
            "clause": "a group of words containing a subject and a predicate",
            "code": "a system of rules or laws that govern conduct or behavior",
            "commission": "to formally assign or authorize someone to perform a task",
            "commit": "to dedicate or pledge oneself to a particular course of action",
            "communicate": "to convey or exchange information or ideas",
            "community": "a group of people living in the same locality or sharing common interests",
            "complex": "consisting of interconnected or interwoven parts",
            "component": "a part or element of a larger whole",
            "compound": "a substance composed of two or more elements or parts",
            "compute": "to calculate or determine by using mathematics or logic",
            "concentrate": "to focus one's attention or efforts on a particular task or activity",
            "concept": "an abstract idea or general notion",
            "conclude": "to arrive at a decision or judgment through reasoning",
            "conduct": "to manage or carry out a particular activity or process",
            "confine": "to restrict or limit within certain boundaries",
            "conflict": "a disagreement or struggle between opposing forces",
            "consent": "permission or agreement to do something",
            "consequent": "following as a result or effect of something",
            "considerable": "large in size, amount, or importance",
            "consist": "to be composed or made up of",
            "constant": "remaining unchanged or consistent over time",
            "construct": "to build or create something, typically a physical object",
            "consume": "to use up or deplete a resource",
            "contact": "to communicate or get in touch with someone",
            "contemporary": "belonging to the same time period or generation",
            "context": "the circumstances or setting in which something occurs",
            "contract": "a legally binding agreement between two or more parties",
            "contrary": "opposite in nature, direction, or meaning",
            "contrast": "to compare or show differences between two or more things",
            "contribute": "to give or supply something, typically in a collaborative effort",
            "convert": "to change something from one form or use to another",
            "convince": "to persuade or win over someone's belief or opinion",
            "core": "the central or essential part of something",
            "couple": "two individuals or items of the same kind considered together",
            "create": "to bring something into existence through artistic or imaginative effort",
            "credit": "recognition or acknowledgement for accomplishments",
            "culture": "the customs, beliefs, arts, and social institutions of a particular group",
            "cycle": "a series of events or processes that repeat in a regular order",
            "data": "facts, figures, or information used to analyze or make decisions",
            "debate": "a formal discussion of opposing arguments on a particular topic",
            "decade": "a period of ten years",
            "decline": "to decrease or diminish in quantity, quality, or importance",
            "define": "to explain the meaning or significance of something",
            "definite": "clearly stated or decided; certain",
            "demonstrate": "to show or prove something through evidence or examples",
            "depress": "to make someone feel sad or disheartened",
            "derive": "to obtain or come from a specific source",
            "design": "to plan or create with a specific purpose in mind",
            "despite": "in spite of; without being affected by",
            "detect": "to discover or notice the presence of something",
            "device": "a tool or machine created for a specific purpose",
            "devote": "to dedicate or commit oneself to a particular activity or cause",
            "display": "to show or exhibit for others to see",
            "distinct": "clearly different or separate from others",
            "distribute": "to divide and give out in shares or portions",
            "domestic": "relating to the home or household; not foreign or international",
            "draft": "a plan, sketch, or rough drawing",
            "economy": "the system or range of economic activity in a country",
            "edit": "to prepare or revise a written or recorded work for publication",
            "element": "a fundamental or essential part of something",
            "eliminate": "to remove or get rid of something completely",
            "emerge": "to come forth or become visible after being concealed",
            "emphasis": "special importance, value, or prominence given to something",
            "enable": "to give the means or opportunity to do something",
            "encounter": "a meeting or unexpected experience with someone or something",
            "energy": "the capacity to do work or produce heat",
            "enormous": "very large in size, extent, or degree",
            "environment": "the surroundings or conditions in which a person, animal, or plant lives",
            "equip": "to supply with necessary tools or resources",
            "equivalent": "equal in value, significance, or function",
            "error": "a mistake or inaccuracy",
            "establish": "to set up or create something that will last for a long time",
            "estate": "a large area of land, especially in the countryside",
            "estimate": "an approximate calculation or judgment of the value or size of something",
            "evaluate": "to assess or judge the value or quality of something",
            "eventual": "occurring at some later time; ultimate",
            "evident": "clearly seen or understood; obvious",
            "evolve": "to develop gradually over time",
            "exhibit": "to display or show a particular quality or characteristic",
            "expand": "to increase in size, volume, quantity, or scope",
            "expert": "a person with special knowledge, skill, or proficiency in a particular area",
            "expose": "to make visible or reveal something that was hidden",
            "external": "relating to the outer or outside part of something",
            "factor": "something that contributes to a result or outcome",
            "feature": "a distinctive attribute or characteristic",
            "federal": "relating to a system of government in which power is divided between a central authority and individual states",
            "fee": "a payment or charge for a service or privilege",
            "file": "a folder or collection of related data stored on a computer",
            "final": "coming at the end; last",
            "flexible": "capable of bending or adjusting easily without breaking",
            "focus": "to direct attention or effort on a specific point or activity",
            "formula": "a mathematical or scientific rule or principle expressed in symbols",
            "found": "to establish or create something, typically an organization or institution",
            "foundation": "the basis or groundwork on which something is built",
            "framework": "a basic structure or model used as a guide for something",
            "function": "the purpose or role that something is designed to fulfill",
            "fund": "to provide financial support for a project or activity",
            "fundamental": "serving as an essential or primary element or basis",
            "furthermore": "in addition to what has been stated",
            "generation": "a group of individuals born and living around the same time",
            "globe": "the earth as a sphere; the world",
            "goal": "a desired result or outcome that one works to achieve",
            "grade": "a level or rank in a scale of values or quality",
            "grant": "to give or bestow something, often as an honor or gift",
            "hence": "as a result or consequence of this; therefore",
            "identical": "exactly the same; alike in every detail",
            "identify": "to recognize or distinguish the nature of something or someone",
            "illustrate": "to explain or clarify by using examples or visual aids",
            "image": "a visual representation or likeness of a person, object, or scene",
            "immigrate": "to move permanently to a new country or region",
            "impact": "the effect or influence of one thing on another",
            "income": "money received, especially on a regular basis, for work or through investments",
            "index": "an alphabetical or numerical list of items for quick reference",
            "indicate": "to point out or show something",
            "individual": "a single person or distinct entity",
            "initial": "occurring at the beginning; first",
            "injure": "to cause harm or damage to something or someone",
            "input": "information or data that is put into a system or process",
            "instance": "an occurrence of something, especially as an example",
            "institute": "an organization or establishment created to promote a particular purpose",
            "intelligent": "having the ability to think, learn, and apply knowledge",
            "intense": "extremely strong or severe; having strong feelings or emotions",
            "internal": "existing or occurring within something; inner",
            "interpret": "to explain or understand the meaning of something",
            "interval": "a period of time between events, actions, or processes",
            "investigate": "to examine or inquire into something systematically",
            "involve": "to include or require as a necessary part",
            "isolate": "to set apart or separate from others",
            "issue": "an important topic or problem for debate or discussion",
            "item": "an individual article or unit; a distinct part or element",
            "job": "a specific piece of work or task performed to earn a living",
            "journal": "a daily record or log of events or transactions",
            "label": "a piece of paper or tag attached to something for identification",
            "layer": "a single thickness or level of material or substance",
            "legal": "relating to the law or its administration",
            "legislate": "to make or enact laws",
            "liberal": "open to new ideas or willing to tolerate different opinions",
            "license": "a permit or official authorization to do something",
            "likewise": "in the same way; also",
            "link": "a connection or relationship between two or more things",
            "locate": "to find the position or place of something",
            "maintain": "to keep in good condition or preserve",
            "major": "greater in size, extent, or importance",
            "manual": "operated or done by hand rather than automatically",
            "margin": "an extra amount or space allowed or available",
            "mature": "fully developed or grown; ripe",
            "maximize": "to increase to the greatest possible amount or degree",
            "mechanism": "a system or process that performs a specific function",
            "media": "the various means of mass communication, such as television, radio, and newspapers",
            "medical": "related to the practice of medicine or healthcare",
            "medium": "an agency or means by which something is conveyed or accomplished",
            "mental": "relating to the mind or intellect; psychological",
            "method": "a particular procedure or way of doing something",
            "military": "relating to the armed forces or soldiers",
            "minimize": "to reduce to the smallest possible degree or extent",
            "minimum": "the smallest or lowest possible quantity or degree",
            "minor": "lesser in size, extent, or importance",
            "mutual": "shared or felt by two or more parties or people",
            "network": "a group or system of interconnected people or things",
            "neutral": "not taking sides in a conflict or dispute",
            "nevertheless": "in spite of that; however",
            "normal": "conforming to a standard or typical pattern",
            "notion": "a general understanding or idea",
            "nuclear": "relating to atomic nuclei or nuclear energy",
            "objective": "a goal or purpose that one works to achieve",
            "obtain": "to get or acquire something, especially through effort",
            "obvious": "easily perceived or understood; clear",
            "occupy": "to take control or possession of a place or location",
            "occur": "to happen or take place; to exist or be found",
            "odd": "different from what is usual or expected; strange",
            "output": "the result or product of a process or activity",
            "overall": "taking everything into account; in general",
            "paragraph": "a distinct section of a piece of writing",
            "parallel": "occurring or existing alongside each other with consistent distance",
            "participate": "to take part in an activity or event",
            "partner": "a person or organization involved in a joint venture or collaboration",
            "percent": "a proportion or rate per 100 units",
            "period": "a length or portion of time",
            "phase": "a distinct stage or step in a process",
            "phenomenon": "an observable event, occurrence, or situation",
            "philosophy": "the study of fundamental questions about existence, knowledge, and values",
            "physical": "relating to the body or material things",
            "plus": "in addition to; with the inclusion of",
            "policy": "a course of action or principle adopted or proposed by a government or organization",
            "portion": "a part or share of a whole",
            "positive": "expressing approval or agreement; optimistic",
            "potential": "having the capability or possibility for future development",
            "precede": "to come before something in time, order, or rank",
            "precise": "exact and accurate in measurement or detail",
            "predict": "to foretell or estimate future events or outcomes",
            "previous": "occurring before in time or order; earlier",
            "primary": "of first importance; main or principal",
            "prime": "first in importance or quality; excellent",
            "principal": "first in rank, authority, or importance",
            "principle": "a fundamental truth or guiding rule",
            "prior": "existing or occurring before in time or order",
            "proceed": "to move forward or continue with a course of action",
            "process": "a series of actions or steps taken to achieve a particular outcome",
            "professional": "relating to a particular profession or occupation",
            "project": "a planned undertaking with specific goals and tasks",
            "promote": "to encourage or support the growth or development of something",
            "proportion": "a part in relation to the whole; a ratio",
            "psychology": "the scientific study of the human mind and behavior",
            "publish": "to make information or a work available to the public",
            "purchase": "to acquire or buy something in exchange for money",
            "radical": "relating to or affecting the fundamental nature of something",
            "range": "the extent or scope of something",
            "ratio": "the quantitative relationship between two amounts",
            "react": "to respond or behave in a particular way in response to something",
            "recover": "to regain health, strength, or normal condition after an illness or injury",
            "region": "an area or division, especially part of a country or the world",
            "register": "to officially record or enroll for a particular purpose",
            "regulate": "to control or direct by rule, principle, or law",
            "relax": "to become less tense or anxious; to rest or take a break",
            "release": "to set free or allow to escape",
            "rely": "to depend on with trust or confidence",
            "remove": "to take away or eliminate",
            "require": "to need something; to make something necessary",
            "research": "the systematic investigation to discover or verify facts and theories",
            "resolve": "to find a solution or make a firm decision about something",
            "resource": "a source of supply or support; a reserve or stock",
            "respond": "to answer or react to something",
            "restrict": "to limit or control the extent or availability of something",
            "reveal": "to make known or disclose something previously hidden",
            "revenue": "income generated or produced by a business or organization",
            "reverse": "to change or move in the opposite direction",
            "revolution": "a dramatic and wide-reaching change in conditions, attitudes, or institutions",
            "rigid": "not flexible or easily bent; firm and unyielding",
            "role": "a function or part played by a person or thing in a particular situation",
            "route": "a course or way taken from one place to another",
            "schedule": "a plan or list of intended events or activities and their timing",
            "section": "a distinct part or portion of something",
            "secure": "safe from harm, danger, or loss",
            "seek": "to attempt to find or obtain something",
            "select": "to carefully choose or pick out from a group",
            "sequence": "a specific order in which events or actions occur",
            "series": "a number of events or things arranged or occurring in succession",
            "sex": "the biological distinction between male and female organisms",
            "shift": "a change in position or direction; a turn",
            "significant": "important or noteworthy; having a meaning or impact",
            "similar": "having characteristics in common; resembling",
            "site": "a place or location where something is situated",
            "so-called": "commonly or mistakenly referred to as",
            "somewhat": "to a moderate extent or degree; a little",
            "source": "the origin or cause of something",
            "specific": "clearly defined or identified; particular",
            "specify": "to state or identify clearly and precisely",
            "sphere": "a round or three-dimensional object or region",
            "stable": "firmly established; not likely to change or move",
            "statistic": "a numerical data point representing a quantity or measurement",
            "status": "the social or professional standing or condition of an individual",
            "stress": "physical or mental strain or tension caused by demanding circumstances",
            "structure": "the arrangement or organization of parts to form a whole",
            "style": "a particular manner or way of expressing something",
            "substitute": "to use or provide as a replacement for something else",
            "sufficient": "enough; adequate for a specific purpose",
            "sum": "the total amount resulting from the addition of two or more numbers",
            "survey": "a systematic study or examination of a subject or area",
            "survive": "to continue to live or exist despite difficult circumstances",
            "suspend": "to temporarily stop or postpone something",
            "symbol": "a mark or sign that represents something else",
            "tape": "a long, narrow strip of material used for various purposes",
            "target": "an object or goal aimed at or to be achieved",
            "task": "a piece of work or job to be completed",
            "team": "a group of individuals working together to achieve a common goal",
            "technical": "relating to a specific field of knowledge or application of scientific principles",
            "technique": "a method or way of accomplishing a particular task",
            "technology": "the application of scientific knowledge for practical purposes",
            "temporary": "lasting for a limited time; not permanent",
            "tense": "a grammatical category that expresses the time of an action or state",
            "text": "written or printed words, especially as distinct from visual images",
            "theme": "a recurring or unifying idea or motif in a work of art or literature",
            "theory": "a systematic explanation of a phenomenon or observed fact",
            "thereby": "by that means; as a result of that",
            "topic": "a subject of discussion, conversation, or study",
            "trace": "to find or discover the origins or development of something",
            "tradition": "a belief, custom, or practice that is passed down from one generation to another",
            "transfer": "to move or convey from one place, person, or position to another",
            "transmit": "to send or communicate information or signals",
            "transport": "to carry or move from one place to another",
            "trend": "a general direction in which something is developing or changing",
            "ultimate": "the highest, most significant, or final point",
            "uniform": "consistent in form, manner, or degree",
            "unique": "being the only one of its kind; distinctive",
            "vary": "to change or differ from one another",
            "vehicle": "a means of transportation or conveyance",
            "version": "a particular form or variation of something",
            "virtual": "existing in essence but not in actuality; simulated",
            "visible": "able to be seen; perceptible to the eye",
            "vision": "the ability to see or the act of seeing",
            "visual": "relating to sight or the sense of vision",
            "volume": "the amount of space that an object or substance occupies",
            "welfare": "the health, happiness, and prosperity of individuals in a community",
            "whereas": "in contrast or comparison with the fact that",
            "widespread": "occurring or found over a large area or among many people"
        }
}
"""
