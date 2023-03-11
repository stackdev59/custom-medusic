import SwiftUI
import SFSafeSymbols

private struct NavigationEntry<Content: View>: View {

    var destination: Content
    var text: String
    var symbol: SFSymbol

    init(
        @ViewBuilder
        destination: () -> Content,
        text: String,
        symbol: SFSymbol
    ) {
        self.destination = destination()
        self.text = text
        self.symbol = symbol
    }

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemSymbol: symbol)
                    .foregroundColor(Color.accentColor)
                    .frame(minWidth: 25)

                Text(text)

                Spacer(minLength: 10)

                Image(systemSymbol: .chevronRight)
                    .font(.footnote)
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }
            .frame(height: 40)
            .buttonStyle(.plain)
            .font(.title3)
        }
        .padding(.leading, 10)
        .padding(.trailing, 15)
    }
}

private struct LibraryNavigationItems: View {
    var body: some View {
        VStack(alignment: .leading) {
            NavigationEntry(
                destination: {},
                text: "Playlists",
                symbol: .musicNoteList
            )
            .disabled(true)

            Divider()

            NavigationEntry(
                destination: {},
                text: "Artists",
                symbol: .musicMic
            )
            .disabled(true)

            Divider()

            NavigationEntry(
                destination: { AlbumLibraryScreen() },
                text: "Albums",
                symbol: .squareStack
            )

            Divider()

            NavigationEntry(
                destination: {},
                text: "Songs",
                symbol: .musicNote
            )
            .disabled(true)

            Divider()

            NavigationEntry(
                destination: {},
                text: "Downloads",
                symbol: .arrowDownApp
            )
            .disabled(true)

            Divider()
        }
    }
}

private struct FavoritesAlbumSection: View {

    var albums: [Album]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Favorite albums")
                .font(.title)
                .bold()
                .padding(.leading, 5)

            AlbumTileListComponent(albums: albums)
                .padding(.leading, 10)
                .padding(.trailing, 10)
        }
    }
}

struct LibraryScreen: View {

    @Environment(\.api)
    var api

    @State
    private var albums: [Album] = []

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    LibraryNavigationItems()
                        .padding(.top, 10)

                    FavoritesAlbumSection(albums: albums)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
            }
            .navigationTitle("Library")
        }
        .onAppear {
            Task {
                Task {
                    do {
                        albums = try await api.albumService.getAlbums(for: "0f0edfcf31d64740bd577afe8e94b752")
                    } catch {
                        print("Failed to fetch albums.")
                    }
                }
            }
        }
    }
}

#if DEBUG
struct LibraryScreen_Previews: PreviewProvider {
    static var previews: some View {
        LibraryScreen()
    }
}
#endif
