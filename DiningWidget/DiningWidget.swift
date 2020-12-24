//
//  DiningWidget.swift
//  DiningWidget
//
//  Created by Lonnie Gerol on 12/21/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct DiningWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            // Location
            VStack(alignment: .leading) {
                HStack {
                    Text("GV Cantina and Grill")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .lineLimit(3)
                        .minimumScaleFactor(0.30)
                        //.scaledToFit()
                        .foregroundColor(.white)
                        //.padding(5)
                    Spacer()
                    Circle()
                        .foregroundColor(Color.green)
                        .frame(width: 25, height: 25, alignment: .center)
                }
            }
            .padding()
            Spacer()
            // Hours
            VStack(alignment: .leading, content: {
                Text("8:00pm - 9:00pm")
                    //.lineLimit(1)
                    //.foregroundColor(Color.white)
                Spacer()
                    .frame(height: 5, alignment: .center)
                Text("12:00pm - 12:00pm")
            })
            .lineLimit(1)
            //.font(.system(size: 13))
            .minimumScaleFactor(0.30)
            //fixedSize(horizontal: true, vertical: false)
            .foregroundColor(Color.white)
            .padding(10)

            Spacer()

        }
        .background(Color.init("RIT Orange"))

        }
    }

@main
struct DiningWidget: Widget {
    let kind: String = "DiningWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            DiningWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Single Location")
        .description("A Widget that displays the hours of operation for a single location.")
    }
}

struct DiningWidget_Previews: PreviewProvider {
    static var previews: some View {
        DiningWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))

    }
}
