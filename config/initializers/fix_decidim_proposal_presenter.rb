# The original source code of Decidim is not taking into account that a coautorship author
# can be a Meeting. This produces errors when trying to render the avatar (or other fields)
# of the author
module FixDecidimProposalPresenter
  def author
    @author ||= if official?
                  Decidim::Proposals::OfficialAuthorPresenter.new
                else
                  coauthorship = coauthorships.first
                  if coauthorship.user_group
                    Decidim::UserGroupPresenter.new(coauthorship.user_group)
                  elsif coauthorship.author.is_a?(Decidim::Meetings::Meeting)
                    Decidim::Meetings::MeetingPresenter.new(coauthorship.author)
                  else
                    Decidim::UserPresenter.new(coauthorship.author)
                  end
                end
  end
end

Decidim::Proposals::ProposalPresenter.prepend(FixDecidimProposalPresenter)
