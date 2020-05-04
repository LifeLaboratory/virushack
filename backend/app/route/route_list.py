from app.route.materials.route import Materials
from app.route.contacts.route import Contacts
from app.route.products.route import Products
from app.route.calendar.route import Calendar
from app.route.survey.route import Survey

ROUTES = {
    '/api/materials': Materials,
    '/api/contacts': Contacts,
    '/api/products': Products,
    '/api/calendar': Calendar,
    '/api/survey': Survey
}
