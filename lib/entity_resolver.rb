require 'url_identity_resolver/null'
require 'url_identity_resolver/apple_music'
require 'url_identity_resolver/deezer'
require 'url_identity_resolver/spotify'
require 'url_identity_resolver/rdio'
require 'url_identity_resolver/soundcloud'
# require 'url_identity_resolver/google_play_music'
require 'beatalong/errors'

class EntityResolver
  RESOLVERS = [
    UrlIdentityResolver::AppleMusic,
    UrlIdentityResolver::Deezer,
    # UrlIdentityResolver::GooglePlayMusic,
    UrlIdentityResolver::Rdio,
    UrlIdentityResolver::Spotify,
    UrlIdentityResolver::Soundcloud,
    UrlIdentityResolver::Null, # This must be the last
  ]

  def self.identity_from(url)
    identity =
      RESOLVERS
        .find { |resolver| resolver.match?(url) }
        .new(url)
        .identity

    raise Beatalong::IdentityNotFound unless identity && identity.valid?

    identity
  end
end
