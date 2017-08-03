//
//  EventsViewController.swift
//  Event
//
//  Created by Joshua Thompson on 18/07/2017.
//  Copyright © 2017 Joshua Thompson. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {

    //MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        EventManager().addEvent(date: NSDate(), description: "", imageUrl: [""])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
        
        navigationController?.delegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        navigationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.delegate = nil

//        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: EventDetailViewController.self) {
            
            let eventDetail = segue.destination as? EventDetailViewController
            
            if let selectedArrayIndex = tableView.indexPathForSelectedRow?.row {
                
                let cell = tableView.cellForRow(at: IndexPath(row: selectedArrayIndex, section: 0)) as? EventTableViewCell
                
                eventDetail?.eventImageView = cell?.eventImageView
            }
        }
    }
    
    //MARK: - Action Events
    
    @IBAction func addEventButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    //MARK: - UINavigationControllerDelegate methods
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        if fromVC == self && toVC.isKind(of: EventDetailViewController.self) {
            
            return TransitionFromEvent()
        }
        
        return nil
    }
}

