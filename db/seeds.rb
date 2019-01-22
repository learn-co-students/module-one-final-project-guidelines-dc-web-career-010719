User.destroy_all
Festival.destroy_all
Planner.destroy_all

serven = User.create(first_name: "Serven", last_name: "Maraghi", location: "Washington, D.C.")
anthony = User.create(first_name: "Anthony", last_name: "Gregg", location: "Silver Spring, MD")
chine = User.create(first_name: "Chine", last_name: "Anikwe", location: "Woodbridge, VA")
ross_the_boss = User.create(first_name: "Ross", last_name: "The Boss", location: "Owen Mills, MD")

coachella = Festival.create(name: "Coachella", location: "Indio, CA", start_date: Date.parse('2019-04-12'), end_date: Date.parse('2019-04-14'), cost: 428.99)
bonnaro = Festival.create(name: "Bonnaro", location: "Manchester, TN", start_date: Date.parse('2019-07-13'), end_date: Date.parse('2019-07-16'), cost: 329.00)
ultra = Festival.create(name: "ULTRA", location: "Manchester, TN", start_date: Date.parse('2019-03-29'), end_date: Date.parse('2019-03-31'), cost: 379.95)
lolla = Festival.create(name: "Lollapalooza", location: "Chicago, IL", start_date: Date.parse('2019-08-01'), end_date: Date.parse('2019-08-04'), cost: 379.95)

trip_ser1 = Planner.create(name: "Hype for Lolla", user: serven, festival: lolla)
trip_ser2 = Planner.create(name: "Excited for 'roo!", user: serven, festival: bonnaro)
trip_ser3 = Planner.create(name: "Tanning in the desert", user: serven, festival: coachella)
trip_ant1 = Planner.create(name: "Making out with tree's", user: anthony, festival: ultra)
trip_ant2 = Planner.create(name: "going to the chi and avoiding R. Kelly", user: anthony, festival: lolla)
trip_chi1 = Planner.create(name: "going to GH for rehab when this is done", user: chine, festival: coachella)
trip_ross1 = Planner.create(name: "bossin' it", user: ross_the_boss, festival: bonnaro)
