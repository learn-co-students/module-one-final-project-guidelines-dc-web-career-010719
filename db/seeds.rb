User.destroy_all
Festival.destroy_all
Planner.destroy_all

serven = User.find_or_create_by(first_name: "Serven", last_name: "Maraghi", location: "Washington, D.C.")
anthony = User.find_or_create_by(first_name: "Anthony", last_name: "Gregg", location: "Silver Spring, MD")
chine = User.find_or_create_by(first_name: "Chine", last_name: "Anikwe", location: "Woodbridge, VA")
ross_the_boss = User.find_or_create_by(first_name: "Ross", last_name: "The Boss", location: "Owen Mills, MD")

coachella = Festival.find_or_create_by(name: "Coachella", location: "Indio, CA", start_date: Date.parse('2019-04-12'), end_date: Date.parse('2019-04-14'), cost: 428.99)
bonnaro = Festival.find_or_create_by(name: "Bonnaroo", location: "Manchester, TN", start_date: Date.parse('2019-07-13'), end_date: Date.parse('2019-07-16'), cost: 329.00)
ultra = Festival.find_or_create_by(name: "ULTRA", location: "Manchester, TN", start_date: Date.parse('2019-03-29'), end_date: Date.parse('2019-03-31'), cost: 379.95)
lolla = Festival.find_or_create_by(name: "Lollapalooza", location: "Chicago, IL", start_date: Date.parse('2019-08-01'), end_date: Date.parse('2019-08-04'), cost: 379.95)
made_in_america = Festival.find_or_create_by(name: "Made in America", location: "Philadelphia, PA", start_date: Date.parse('2019-08-31'), end_date: Date.parse('2019-09-01'), cost: 379.95)
sxsw = Festival.find_or_create_by(name: "SXSW", location: "Austin, TX", start_date: Date.parse('2019-03-08'), end_date: Date.parse('2019-03-17'), cost: 1225.00)
firefly = Festival.find_or_create_by(name: "Firefly", location: "Dover, Delaware", start_date: Date.parse('2019-06-21'), end_date: Date.parse('2019-06-23'), cost: 299.00)
govenors_ball = Festival.find_or_create_by(name: "New York, New York", location: "C", start_date: Date.parse('2019-05-31'), end_date: Date.parse('2019-06-02'), cost: 379.95)
nola = Festival.find_or_create_by(name: "New Orleans Jazz & Heritage Festival", location: "New Orleans, LA", start_date: Date.parse('2019-04-26'), end_date: Date.parse('2019-05-05'), cost: 500.00)
bm = Festival.find_or_create_by(name: "Burning Man", location: "Black Rock Desert, NV", start_date: Date.parse('2019-08-25'), end_date: Date.parse('2019-09-02'), cost: 425.00)

# trip_ser1 = Planner.find_or_create_by(name: "Hype for Lolla", user: serven, festival: lolla)
# trip_ser2 = Planner.find_or_create_by(name: "Excited for 'roo!", user: serven, festival: bonnaro)
# trip_ser3 = Planner.find_or_create_by(name: "Tanning in the desert", user: serven, festival: coachella)
# trip_ant1 = Planner.find_or_create_by(name: "Making out with tree's", user: anthony, festival: ultra)
# trip_ant2 = Planner.find_or_create_by(name: "going to the chi and avoiding R. Kelly", user: anthony, festival: lolla)
# trip_chi1 = Planner.find_or_create_by(name: "going to GH for rehab when this is done", user: chine, festival: coachella)
# trip_ross1 = Planner.find_or_create_by(name: "bossin' it", user: ross_the_boss, festival: bonnaro)
