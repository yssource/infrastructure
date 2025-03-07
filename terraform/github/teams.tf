locals {
  github_teams = {
    asdf-core = {
      description = "Core team"
      maintainers = [
        "smorimoto",
        "vic",
      ]
    }

    asdf-infrastructure = {
      description = "Infrastructure team"
      maintainers = [
        "smorimoto",
        "vic",
      ]
      members = [
        "nzws",
      ]
    }

    asdf-alp = {
      description = "The people with push access to the asdf-alp repository"
      maintainers = [
        "smorimoto",
      ]
    }

    asdf-alpine = {
      description = "The people with push access to the asdf-alpine repository"
      maintainers = [
        "vic",
      ]
    }

    asdf-aocc = {
      description = "The people with push access to the asdf-aocc repository"
      maintainers = [
        "smorimoto",
      ]
    }

    asdf-aria2 = {
      description = "The people with push access to the asdf-aria2 repository"
      maintainers = [
        "smorimoto",
      ]
    }

    asdf-arkade = {
      description = "The people with push access to the asdf-arkade repository"
      maintainers = [
        "looztra",
      ]
    }

    asdf-ccache = {
      description = "The people with push access to the asdf-ccache repository"
      maintainers = [
        "smorimoto",
      ]
    }

    asdf-chezscheme = {
      description = "The people with push access to the asdf-chezscheme repository"
      maintainers = [
        "vic",
      ]
    }

    asdf-clojure = {
      description = "The people with push access to the asdf-clojure repository"
      maintainers = [
        "vic",
      ]
    }

    asdf-cmake = {
      description = "The people with push access to the asdf-cmake repository"
      maintainers = [
        "amrox",
      ]
    }

    asdf-cmctl = {
      description = "The people with push access to the asdf-crystal repository"
      maintainers = [
        "superbrothers",
      ]
    }

    asdf-crystal = {
      description = "The people with push access to the asdf-crystal repository"
      maintainers = [
        "marciogm",
      ]
    }

    asdf-cue = {
      description = "The people with push access to the asdf-cue repository"
      maintainers = [
        "NeoHsu",
        "spencergilbert",
      ]
    }

    asdf-dasel = {
      description = "The people with push access to the asdf-dasel repository"
      maintainers = [
        "ghostsquad",
        "TomWright",
      ]
    }

    asdf-deno = {
      description = "The people with push access to the asdf-deno repository"
      maintainers = [
        "smorimoto",
      ]
    }

    asdf-direnv = {
      description = "The people with push access to the asdf-direnv repository"
      maintainers = [
        "michi-zuri",
        "smorimoto",
        "vic",
      ]
    }

    asdf-dotty = {
      description = "The people with push access to the asdf-dotty repository"
      maintainers = [
        "vic",
      ]
    }

    asdf-dprint = {
      description = "The people with push access to the asdf-dprint repository"
      maintainers = [
        "SnO2WMaN",
      ]
    }

    asdf-elasticsearch = {
      description = "The people with push access to the asdf-elasticsearch repository"
      maintainers = [
        "michaelstephens",
      ]
    }

    asdf-elm = {
      description = "The people with push access to the asdf-elm repository"
      maintainers = [
        "brianvanburken",
      ]
    }

    asdf-getenvoy = {
      description = "The people with push access to the asdf-getenvoy repository"
      maintainers = [
        "superbrothers",
      ]
    }

    asdf-grpcurl = {
      description = "The people with push access to the asdf-grpcurl repository"
      maintainers = [
        "superbrothers",
      ]
    }

    asdf-hashicorp = {
      description = "The people with push access to the asdf-hashicorp repository"
      maintainers = [
        "DustinChaloupka",
        "nathantypanski",
        "radditude",
      ]
    }

    asdf-kotlin = {
      description = "The people with push access to the asdf-kotlin repository"
      maintainers = [
        "missingcharacter",
      ]
    }

    asdf-ktlint = {
      description = "The people with push access to the asdf-ktlint repository"
      maintainers = [
        "esensar",
      ]
    }

    asdf-kubectl = {
      description = "The people with push access to the asdf-kubectl repository"
      maintainers = [
        "DustinChaloupka",
      ]
    }

    asdf-nim = {
      description = "The people with push access to the asdf-nim repository"
      maintainers = [
        "elijahr",
      ]
    }

    asdf-peco = {
      description = "The people with push access to the asdf-peco repository"
      maintainers = [
        "smorimoto",
      ]
    }

    asdf-poetry = {
      description = "The people with push access to the asdf-poetry repository"
      maintainers = [
        "crflynn",
      ]
    }

    asdf-php = {
      description = "The people with push access to the asdf-php repository"
      maintainers = [
        "smorimoto",
      ]
    }

    asdf-r = {
      description = "The people with push access to the asdf-r repository"
      maintainers = [
        "taiar",
      ]
    }

    asdf-scala = {
      description = "The people with push access to the asdf-scala repository"
      maintainers = [
        "mtatheonly",
      ]
    }

    asdf-sml = {
      description = "The people with push access to the asdf-sml repository"
      maintainers = [
        "nverno",
      ]
    }

    asdf-svu = {
      description = "The people with push access to the asdf-svu repository"
      maintainers = [
        "ghostsquad",
        "caarlos0",
      ]
    }

    asdf-tridentctl = {
      description = "The people with push access to the asdf-tridentctl repository"
      maintainers = [
        "superbrothers",
      ]
    }

    asdf-zig = {
      description = "The people with push access to the asdf-zig repository"
      maintainers = [
        "smorimoto",
      ]
    }
  }
}

resource "github_team" "teams" {
  for_each = local.github_teams

  name        = each.key
  description = each.value.description
  privacy     = "closed"
}

resource "github_team_membership" "team_membership" {
  for_each = { for i in flatten(
    [for team_name, team in local.github_teams : [
      [for username in lookup(team, "maintainers", []) : {
        team_name = team_name,
        username  = username,
        role      = "maintainer",
      }],
      [for username in lookup(team, "members", []) : {
        team_name = team_name,
        username  = username,
        role      = "member",
      }],
    ]]) : format("%s.%s", i.team_name, i.username) => i
  }

  team_id  = github_team.teams[each.value.team_name].id
  role     = each.value.role
  username = each.value.username
}
