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
    var currentDate = Date()

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
    
    // MARK: - 달력
    
    @IBAction func pastMonthBtn(_ sender: Any) {
        print("111pastMonthBtn clicked!")
        
        currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) ?? currentDate
        
        print("111Updated Date: \(currentDate)")

        updateCalendar()
    }
    
    @IBAction func nextMonthBtn(_ sender: Any) {
        print("111nextMonthBtn clicked!")

        currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
        
        print("111Updated Date: \(currentDate)")

        updateCalendar()
    }
    
    func updateCalendar() {
        print("111Updating calendar for new date: \(currentDate)")
        daysArray = generateDaysForCurrentMonth()
        collectionView.reloadData()
        print("111Reloaded Collection View with days count: \(daysArray.count)")
    }
    
    @IBOutlet weak var monthLabel: UILabel!

    // 현재 월의 날짜 배열 생성
    func generateDaysForCurrentMonth() -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        let currentMonth = dateFormatter.string(from: currentDate)
        monthLabel.text = currentMonth

        print("Current Month: \(currentMonth)")

        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: currentDate)!

        let numDays = range.count
        var days = [String]()

        let firstWeekday = calendar.component(.weekday, from: calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!)

        for _ in 1..<firstWeekday {
            days.append("")
        }

        for day in 1...numDays {
            days.append("\(day)")
        }

        print("Generated Days: \(days)")
        return days
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        cell.dateLabel.text = daysArray[indexPath.item]
        cell.emojiLabel.text = "😐"
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
        return 30 // 줄 간격
    }
}
