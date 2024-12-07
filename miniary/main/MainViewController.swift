//
//  ViewController.swift
//  DynamicCollectionView
//
//  Created by User on 12/7/24.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    let daysInWeek = 7
    var daysArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

        // 날짜 배열 생성
        daysArray = generateDaysForCurrentMonth()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 레이아웃 무효화로 동적 크기 반영
        collectionView.collectionViewLayout.invalidateLayout()
    }

    @IBAction func addBtn(_ sender: Any) {
        print("addBtn clicked!")
        let storyboard = UIStoryboard(name: "Add", bundle: nil)
        if let addViewController = storyboard.instantiateViewController(withIdentifier: "AddViewController") as? AddViewController {
            self.navigationController?.pushViewController(addViewController, animated: true)
        }
    }

    @IBOutlet weak var monthLabel: UILabel!

    // 현재 월의 날짜 배열 생성
    func generateDaysForCurrentMonth() -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let currentMonth = dateFormatter.string(from: Date())
        monthLabel.text = currentMonth

        let calendar = Calendar.current
        let date = Date()
        let range = calendar.range(of: .day, in: .month, for: date)!

        let numDays = range.count
        var days = [String]()

        // 앞부분의 공백을 위해 현재 월의 첫 번째 요일 계산
        let firstWeekday = calendar.component(.weekday, from: calendar.date(from: calendar.dateComponents([.year, .month], from: date))!)

        // 빈 칸 추가 (1일 전에 해당하는 빈 칸)
        for _ in 1..<firstWeekday {
            days.append("")
        }

        // 1일부터 월의 마지막 날까지 추가
        for day in 1...numDays {
            days.append("\(day)")
        }

        return days
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        cell.emojiLabel.text = daysArray[indexPath.item]
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width // 컬렉션 뷰의 전체 너비
        let numberOfColumns: CGFloat = 7 // 열 개수
        let spacing: CGFloat = 1 // 셀 간 간격
        let totalSpacing = spacing * (numberOfColumns - 1) // 총 간격

        // 셀의 너비 계산
        let cellWidth = floor((totalWidth - totalSpacing) / numberOfColumns)

        print("Collection View Width: \(totalWidth)")
        print("Calculated Cell Width: \(cellWidth)")

        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1 // 셀 간 간격
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1 // 줄 간격
    }
}
