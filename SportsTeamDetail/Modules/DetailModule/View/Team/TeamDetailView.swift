import UIKit

final class TeamDetailView: UIView {
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "PlayerTableViewCell")
    return tableView
  }()

  private let theme: Theme

  private var team: Team = .init(squads: [])

  init(theme: Theme) {
    self.theme = theme
    super.init(frame: .zero)

    setupView()
    setupTableView()
  }

  @available(*,unavailable)
  required init?(coder: NSCoder) {
    nil
  }

  func updateTeam(_ team: Team) {
    self.team = team
    tableView.reloadData()
  }

  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }

  private func setupView() {
    backgroundColor = theme.primaryBackgroundColor
    tableView.backgroundColor = theme.secondaryBackgroundColor
    tableView.separatorColor = theme.dividerColor

    let headerView = DetailHeaderView(theme: theme)
    addSubview(headerView)
    headerView.anchor(
      top: topAnchor,
      left: leadingAnchor,
      right: trailingAnchor,
      height: 330
    )

    let optionsView = DetailOptionsView(delegate: self, theme: theme)
    addSubview(optionsView)
    optionsView.anchor(
      top: headerView.bottomAnchor,
      paddingTop: 0,
      left: leadingAnchor,
      right: trailingAnchor,
      height: 44
    )

    addSubview(tableView)
    tableView.anchor(
      top: optionsView.bottomAnchor,
      paddingTop: 0,
      left: leadingAnchor,
      bottom: bottomAnchor,
      right: trailingAnchor
    )
  }
}

// MARK: DetailOptionsProtocol

extension TeamDetailView: DetailOptionsProtocol {
  func didSelectSquads() {
    tableView.isHidden = false
  }

  func didSelectOther() {
    tableView.isHidden = true
  }
}

// MARK: UITableViewDelegate & UITableViewDataSource

extension TeamDetailView: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return team.squads.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let section = team.squads[section]

    if section.isOpened {
      return section.player.count + 1
    } else {
      return 1
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
    cell.backgroundColor = theme.primaryBackgroundColor

    if indexPath.row == 0 {
      cell.textLabel?.text = team.squads[indexPath.section].name
    }
    else {
      let player = team.squads[indexPath.section].player[indexPath.row - 1]
      cell.playerImage.image = UIImage(named: "player")
      cell.playerName.text = player.name
      cell.playerCountry.text = player.country
      cell.scoreLabel.text = player.score
    }

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      team.squads[indexPath.section].isOpened = !team.squads[indexPath.section].isOpened
      tableView.reloadSections([indexPath.section], with: .none)
    }
  }
}
